import unittest
from update_apps import get_latest_version

class UpdateAppsTest(unittest.TestCase):
    def test_get_latest_version_first_position(self):
        self.assertEqual(get_latest_version(['1.0.0', '2.0.0']), '2.0.0')
        self.assertEqual(get_latest_version(['2.0.0', '1.0.0']), '2.0.0')

    def test_get_latest_version_second_position(self):
        self.assertEqual(get_latest_version(['1.0.0', '1.1.0']), '1.1.0')
        self.assertEqual(get_latest_version(['1.1.0', '1.0.0']), '1.1.0')

    def test_get_latest_version_third_position(self):
        self.assertEqual(get_latest_version(['1.0.1', '1.0.0']), '1.0.1')
        self.assertEqual(get_latest_version(['1.0.0', '1.0.1']), '1.0.1')

if __name__ == '__main__':
    unittest.main()