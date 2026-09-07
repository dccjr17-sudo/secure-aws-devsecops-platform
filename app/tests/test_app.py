"""Tests for the minimal application health endpoints."""

import unittest

from src.app import create_app


class ApplicationTestCase(unittest.TestCase):
    def setUp(self):
        self.client = create_app().test_client()

    def test_health_endpoint_reports_ok(self):
        response = self.client.get("/health")

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_json(), {"status": "ok"})

    def test_index_identifies_the_platform(self):
        response = self.client.get("/")

        self.assertEqual(response.status_code, 200)
        self.assertEqual(
            response.get_json()["application"], "secure-aws-devsecops-platform"
        )
