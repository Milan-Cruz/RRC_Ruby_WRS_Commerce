# Base image: Official Ruby with a specific version
FROM ruby:3.2.0

# Update system packages and install required dependencies
RUN apt-get update -qq && \
  apt-get install -y \
  nodejs \
  build-essential \
  curl \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libvips libvips-dev \
  imagemagick

# Set the container's working directory
WORKDIR /myapp

# Add Gemfile and Gemfile.lock to the working directory
COPY Gemfile Gemfile.lock ./

# Install Bundler and project gem dependencies
RUN gem install bundler && bundle install

# Copy the application source code into the container
COPY . .

# Precompile assets if applicable (e.g., for Rails projects with a frontend)
RUN bundle exec rake assets:precompile

# Open the default Rails port for external access
EXPOSE 3000

# Define the command to run the application server
CMD ["rails", "server", "-b", "0.0.0.0"]