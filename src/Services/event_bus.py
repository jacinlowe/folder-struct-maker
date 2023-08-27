import asyncio
from collections import Counter


class EventBus:
    def __init__(self) -> None:
        self.events: dict[str, set] = {}

    def __repr__(self) -> str:
        """Returns EventBus string representation.

        :return: Instance with how many subscribed events.
        """
        return "<{}: {} subscribed events>".format(self.cls_name, self.event_count)

    def __str__(self) -> str:
        """Returns EventBus string representation.

        :return: Instance with how many subscribed events.
        """

        return "{}".format(self.cls_name)

    @property
    def event_count(self) -> int:
        return self._subscribed_event_count()

    @property
    def cls_name(self) -> str:
        return self.__class__.__name__

    def add_event(self, event_name: str) -> None:
        if not self.events.get(event_name, None):
            self.events[event_name] = {}

    def add_listener(self, event_name: str, listener) -> None:
        if not self.events.get(event_name, None):
            self.events[event_name] = {listener}
        else:
            self.events[event_name].add(listener)

    def remove_listener(self, event_name: str, listener) -> None:
        self.events[event_name].remove(listener)

        if len(self.events[event_name]) == 0:
            del self.events[event_name]

    def emit(self, event_name: str, event) -> None:
        listeners = self.events.get(event_name, [])
        for listener in listeners:
            asyncio.create_task(listener(event))

    def _subscribed_event_count(self) -> int:
        event_counter = Counter()
        for k, v in self.events.items():
            event_counter[k] = len(v)

        return sum(event_counter.values())
