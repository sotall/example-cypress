#!/bin/bash

# Delete previousruns
rm -rf demo

# Install Cypress
mkdir -p demo
cd demo || exit
npm init -y
npm install cypress@12.0.0 --save-dev

# Create the e2e folder if it doesn't exist
mkdir -p cypress/e2e

# Create the Cypress test spec file
filename="cypress/e2e/example.cy.js"
cat >$filename <<EOL
describe('template spec', () => {
  it('passes', () => {
    cy.visit('https://example.cypress.io')
  })
})
EOL

echo "Created $filename"

# Create the Cypress Config file
filename="Cypress.config.js"
cat >$filename <<EOL
const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    supportFile: false,
    specPattern: 'cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
EOL

echo "Created $filename"

# Run the test
npx cypress run --headed --browser chrome
