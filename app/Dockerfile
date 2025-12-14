# Lightweight Python image
FROM python:3.11-slim


# Create non-root user
RUN useradd --create-home appuser
WORKDIR /home/appuser


# Install dependencies
COPY ./requirements.txt /tmp/requirements.txt
RUN python -m pip install --upgrade pip && \
python -m pip install --no-cache-dir -r /tmp/requirements.txt && \
rm -rf /root/.cache


# Copy app
COPY ./main.py ./


# Change ownership and switch to non-root user
RUN chown -R appuser:appuser /home/appuser
USER appuser


# Port used by Cloud Run
ENV PORT=8080
EXPOSE 8080


CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]