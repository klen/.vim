# -*- coding: utf-8 -*-

from django.test import TestCase


class BaseTestCase(TestCase):

    def setUp(self):
        pass

    def test_response(self):
        response = self.client.get('')
        self.assertEqual(response.status_code, 200)
