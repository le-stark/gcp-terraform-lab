
build {
  name = "manhlnd1-packer-build"
  sources = ["source.googlecompute.ubuntu"]
  provisioner "shell" {
    environment_vars = [
      "TEMP=hello world",
    ]
    execute_command = local.execute_command
    inline = [
      "echo Installing nginx",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo ufw allow proto tcp from any to any port 22,80,443",
      "echo 'y' | sudo ufw enable",
      "sudo apt install stress-ng -y",
      "echo \"Hello world from $(hostname) $(hostname -I) with ManhLND1\" > /var/www/html/index.html"
    ]
  }
}