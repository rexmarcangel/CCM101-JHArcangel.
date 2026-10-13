
## Our Learning Experience

Our group learned more about cloud computing and how it is used in actual IT environments. At first, we mainly learned the basic concepts of cloud services, deployment models, and different cloud platforms. As we continued with the laboratory activities, we started working with tools and technologies that helped us understand how cloud infrastructure operates.

One of the important lessons we learned was that cloud computing is not only about storing files online. It also involves managing servers, networks, applications, databases, security, and backups. Each laboratory gave us a better idea of how these components work together.

## Skills We Developed

During the activities, we gained experience with GitHub documentation, Linux commands, Docker containers, and cloud storage concepts. We also learned the differences between block, file, and object storage and why choosing the appropriate storage type depends on the needs of a project.

In our final laboratory, we deployed Nextcloud with MariaDB using Docker Compose. We configured persistent volumes so that data could remain available beyond the lifetime of an individual container. We also configured UFW to control incoming connections and prepared a Bash script that creates compressed database backups.

These tasks helped us understand the importance of planning a deployment properly instead of focusing only on making the application run.

## Challenges We Encountered

One challenge was understanding how the different components communicate with each other. We had to pay attention to the Docker Compose configuration, database environment variables, network settings, and the way the virtual machine connects to the host computer.

We also learned that a working application still needs proper security and maintenance. Firewall rules must allow only the necessary connections, credentials should remain private, and backups should be checked rather than simply assumed to be working.

These challenges taught us to check logs, review configuration files, test commands carefully, and solve problems one step at a time.

## Importance of Security and Maintenance

Our final project helped us realize that deploying a private cloud system is only the beginning. It also needs regular monitoring, updates, secure access, persistent storage, and a reliable recovery plan.

We learned that database backups alone are not enough to restore a complete Nextcloud environment because uploaded files and configuration must also be protected. In a real deployment, we would improve our project by adding HTTPS, storing backups outside the virtual machine, testing restoration regularly, and restricting access to trusted networks.

## Application to Future Projects

The knowledge we gained from these missions can help us with future system administration, backend development, and cloud infrastructure projects. Understanding containers, databases, networking, and automation will also help us troubleshoot applications more effectively.

As IT students, we learned that successful deployment requires patience, proper documentation, teamwork, and continuous testing. We may still have more to learn, but these activities gave us a better foundation for working with cloud technologies.


