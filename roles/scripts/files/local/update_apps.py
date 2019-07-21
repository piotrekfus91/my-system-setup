import requests
import os
import urllib
import subprocess
from functional import seq
from distutils.version import LooseVersion

class App:
    def __init__(self, repo, app_name, version_parser):
        self.repo = repo
        self.app_name = app_name
        self.version_parser = version_parser

notification_file_path = '/tmp/apps_versions'
apps_dir = os.path.expanduser('~/apps/bin/')
apps = [
    App(repo = 'ogham/exa', app_name = 'exa', version_parser = lambda str: str[(len('exa ')):]),
    App(repo = 'sharkdp/bat', app_name = 'bat', version_parser = lambda str: str[(len('bat ')):]),
    App(repo = 'sharkdp/fd', app_name = 'fd', version_parser = lambda str: str[(len('fd ')):])
]

def ensure_app_folder_exists():
    if not os.path.exists(apps_dir):
        os.makedirs(apps_dir)

def recreate_notification_file():
    return open(notification_file_path, 'w')

def install_or_update(app, notify_file):
    all_releases = get_all_releases(app)
    all_versions = get_all_versions(all_releases)
    latest_version = get_latest_version(all_versions)
    current_version = get_current_version(app)
    notify_of_version_mismatch(app, latest_version, current_version, notify_file)

def get_all_releases(app):
    releases_url = 'https://api.github.com/repos/{}/releases'.format(app.repo)
    response = requests.get(releases_url)
    return response.json()

def get_all_versions(releases):
    return seq(releases).filter(lambda x: x["draft"] == False).map(lambda x: x["tag_name"]).to_list()

def get_latest_version(versions):
    versions.sort(key = lambda x: x.split('.'))
    return stripV(versions[-1])

def stripV(version):
    return version[1:] if version.startswith('v') else version

def get_current_version(app):
    app_path = apps_dir + app.app_name
    if not os.path.exists(app_path):
        return None
    version_str = subprocess.check_output([apps_dir + app.app_name, '--version']).strip()
    return stripV(app.version_parser(version_str))

def notify_of_version_mismatch(app, latest_version, current_version, notify_file):
    if (current_version == None):
        notify_file.write("App " + app.app_name + " is not installed\n")
    elif (LooseVersion(latest_version) != LooseVersion(current_version)):
        notify_file.write("App " + app.app_name + " version mismatch, current: " + current_version + ", latest: " + latest_version + "\n")

def close_file(file):
    file.close()

def remove_file_if_empty(file_path):
    if os.stat(file_path).st_size == 0:
        os.remove(file_path)

if __name__ == '__main__':
    ensure_app_folder_exists()
    notify_file = recreate_notification_file()
    for app in apps:
        try:
            install_or_update(app, notify_file)
        except Exception as e:
            print e
    close_file(notify_file)
    remove_file_if_empty(notification_file_path)
