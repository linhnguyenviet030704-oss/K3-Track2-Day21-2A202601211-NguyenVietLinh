#!/bin/bash
cat << 'EOF' | sudo tee /etc/systemd/system/mlops-serve.service > /dev/null
[Unit]
Description=MLOps Model Inference Server
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu
Environment="S3_BUCKET=lab21-046989631558-ap-southeast-2-an"
Environment="AWS_DEFAULT_REGION=ap-southeast-2"
ExecStart=/home/ubuntu/venv/bin/uvicorn src.serve:app --host 0.0.0.0 --port 8000
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable mlops-serve
echo "Service configured with ~/venv/bin/uvicorn successfully!"
