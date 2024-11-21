// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"; // Turbo for faster navigation and page updates
import "controllers"; // Stimulus controllers for enhanced interactivity

// Import Bootstrap JS and its dependency Popper.js
import "bootstrap";
import "@popperjs/core";

// Import custom styles (SCSS) if applicable
import "../stylesheets/application";
