# Money Shower

Slack notifications after a payment.
Inspired by https://github.com/fitztrev/make-it-rain (just using a HTTP post call instead of stripe events)

# Usage

1. Deploy the app
2. Set your environment variable `SLACK_WEBHOOK_URL`
3. Send calls to `/now` with these parameters:
 - amount
 - currency
