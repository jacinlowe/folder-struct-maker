import unittest
import os

from dataservice import DataService


class TestDataService(unittest.TestCase):
    def setUp(self):
        self.file_path = "test_data.json"
        self.data_service = DataService(self.file_path)

    def tearDown(self):
        if os.path.exists(self.file_path):
            os.remove(self.file_path)

    def test_save_and_load_data(self):
        data_to_save = [{"key": "name", "value": "John"}, {"key": "age", "value": "30"}]

        # Save data
        self.data_service.save_data(data_to_save)

        # Load data
        loaded_data = self.data_service.load_data()

        # Assert that loaded data matches saved data
        self.assertEqual(loaded_data, data_to_save)


if __name__ == "__main__":
    unittest.main()
