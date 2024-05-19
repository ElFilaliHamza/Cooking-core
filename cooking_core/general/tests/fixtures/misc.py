import pytest
from django.test import override_settings


# this autouse=True parametert says that this fixture will be used and executed for all tests
@pytest.fixture(autouse=True)
def test_settings(settings):
    with override_settings(SECRET_KEY='b27c612c6cbeac10c8788fbc95b29f563cc0ea2eb7d6be08',):
        # means whenever pytest tries to execute this fixture, it will execute the test
        # code inside the with block and in the yield statement, it will return the value
        # of the last executed statement
        yield
