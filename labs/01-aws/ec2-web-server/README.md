# EC2 Web Server Deployment

**Date Completed:** December 1, 2024  
**Lab Duration:** ~2 hours  
**Status:** ✅ Completed

## Objective
Deploy a web server on AWS EC2 with automated installation using user data scripts.

## What I Built
- Ubuntu 22.04 EC2 instance (t2.micro - free tier)
- Nginx web server serving custom HTML
- Elastic IP for static public address
- Security groups configured for HTTP and SSH access
- Automated setup via user data script (no manual installation needed)

## Architecture
```
Internet
    ↓
Security Group (Firewall)
    ↓ (allows HTTP:80, SSH:22)
EC2 Instance (Ubuntu 22.04)
    ↓
Nginx Web Server
    ↓
Custom HTML Page
```

## Skills Demonstrated
- AWS EC2 instance creation and configuration
- Linux system administration (apt package management)
- Bash scripting for automation
- Network security (security groups, firewall rules)
- SSH key management
- Troubleshooting connection issues

## Steps Taken

### 1. Launch EC2 Instance
- AMI: Ubuntu Server 22.04 LTS
- Instance type: t2.micro (1 vCPU, 1GB RAM)
- Key pair: Created for SSH access
- Storage: 8GB gp3 (SSD)

### 2. Configure Security Group
**Inbound Rules:**
- SSH (port 22): My IP only (security best practice)
- HTTP (port 80): 0.0.0.0/0 (public web access)

### 3. Add User Data Script
See `user-data.sh` - automates:
- System updates
- Nginx installation
- Custom HTML page creation
- Service startup and enablement

### 4. Assign Elastic IP
- Allocated static public IP
- Associated with instance
- IP persists through stop/start cycles

### 5. Test Deployment
- Accessed via `http://[elastic-ip]`
- Verified custom HTML displays
- Confirmed nginx service running

## Commands Used

### On Local Machine (SSH Connection)
```bash
# Connect to instance
ssh -i my-key.pem ubuntu@[elastic-ip]

# Check nginx status
sudo systemctl status nginx

# View nginx logs
sudo journalctl -u nginx

# Test locally
curl localhost
```

### User Data Script Commands
See `user-data.sh` for automated commands

## Key Learnings

### Technical Concepts
1. **User Data Scripts**
   - Run once on first boot (by default)
   - Execute as root user
   - Perfect for initial configuration
   - Check logs: `/var/log/cloud-init-output.log`

2. **Security Groups**
   - Stateful firewalls (return traffic auto-allowed)
   - Rules apply immediately
   - Can be modified after instance creation
   - Best practice: Restrict SSH to specific IPs

3. **Elastic IPs**
   - Static public IPv4 addresses
   - Persist through stop/start
   - Cost $0.005/hour if NOT attached to running instance
   - Free when attached to running instance

### Troubleshooting
**Issue:** Browser timeout when accessing public IP  
**Cause:** Security group missing HTTP inbound rule  
**Solution:** Added port 80 rule, verified connection

**Issue:** Browser defaulting to HTTPS  
**Cause:** Modern browsers assume HTTPS  
**Solution:** Explicitly typed `http://` in URL

## Best Practices Applied
- ✅ Restricted SSH access to my IP only (not 0.0.0.0/0)
- ✅ Used user data for automation (infrastructure as code mindset)
- ✅ Enabled nginx service for auto-start on boot
- ✅ Tagged instance with descriptive name
- ✅ Cleaned up resources after testing (stopped instances, released unused Elastic IPs)

## Real-World Applications
This basic setup demonstrates the foundation for:
- Web application hosting
- API servers
- CI/CD build agents
- Development/testing environments

In production, this would be extended with:
- HTTPS/SSL certificates
- Load balancers for high availability
- Auto Scaling Groups for dynamic capacity
- CloudWatch monitoring and alarms
- Backup and disaster recovery

## Next Steps
- [ ] Deploy multiple instances behind a load balancer
- [ ] Set up auto scaling based on traffic
- [ ] Add HTTPS with SSL certificate
- [ ] Implement monitoring with CloudWatch
- [ ] Automate with Terraform

## Resources
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [User Data Scripts Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

---

**Cost:** ~$0 (free tier eligible)  
**Time to Deploy:** ~5 minutes (after learning the process)  
**Difficulty:** Beginner ⭐
