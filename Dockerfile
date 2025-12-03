# Use official Python image
FROM python:3.11

# Install Flask
RUN pip install --no-cache-dir --progress-bar off flask

# Set working directory
WORKDIR /home/myapp

# Copy app files
COPY sample_app.py /home/myapp/
COPY templates /home/myapp/templates/
COPY static /home/myapp/static/

# Expose port
EXPOSE 5050

# Run the app
CMD ["python", "sample_app.py"]
