# Mission Reflection

This laboratory helped me understand why Docker Compose is useful when working with cloud applications. Instead of manually typing several `docker run` commands and configuring each container one by one, I only needed to write the settings in a `docker-compose.yml` file. After that, I could use one command to start the whole environment. This makes the deployment process faster, more organized, and easier to repeat.

I also learned that YAML is very sensitive to indentation. Using the wrong number of spaces or accidentally using a Tab can cause an error when Docker Compose tries to read the file. At first, the indentation may look simple, but I realized that even a small formatting mistake can prevent the entire deployment from working.

The environment variables were also important because they allowed the containers to share the database configuration. For example, the `MYSQL_PASSWORD`, `MYSQL_DATABASE`, and `MYSQL_USER` variables tell Nextcloud which credentials and database information it needs to connect to MariaDB. This also keeps the configuration organized instead of putting everything directly into application commands.

It was interesting to see Nextcloud running after only a few commands. I was able to deploy an enterprise-style private cloud storage system in just a few minutes. Seeing the Nextcloud installation page made the activity feel more realistic because I could see how the different containers worked together.

Compared to Mission 1, my understanding of cloud computing has improved a lot. Before, I mostly understood cloud computing as using online services and remote storage. Now I have a better idea of what happens behind those services, including containers, databases, networking, storage, and deployment. I also learned that cloud engineering is not only about using cloud platforms but also about designing and managing the infrastructure that applications depend on.

