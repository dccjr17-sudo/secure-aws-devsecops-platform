"""Minimal workload for the Secure AWS DevSecOps Application Platform."""

from flask import Flask, jsonify


def create_app() -> Flask:
    """Create and configure the application instance."""
    app = Flask(__name__)

    @app.get("/")
    def index():
        return jsonify(
            application="secure-aws-devsecops-platform",
            message="Application is running.",
        )

    @app.get("/health")
    def health():
        return jsonify(status="ok")

    return app
