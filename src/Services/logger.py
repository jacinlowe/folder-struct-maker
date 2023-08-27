import time
from colorama import Fore, Back, Style

from datetime import datetime


class Logger:
    _instance = None
    logs = []

    @staticmethod
    def getInstance():
        if Logger._instance == None:
            Logger()
        return Logger()._instance

    def __init__(self) -> None:
        if self._instance != None:
            raise Exception("Must only be one")
        else:
            self._instance = self

    def log(self, message: str):
        today = Fore.RED + str(datetime.now())
        log_msg = f"[{today}]: {Fore.GREEN + message}"
        self.logs.append(log_msg)
        print(log_msg)
