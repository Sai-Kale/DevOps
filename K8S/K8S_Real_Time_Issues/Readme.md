# GENERIC K8S ISSUES

- https://k8s-issues.purutuladhar.com/

# K8s Real Time Issues and Debugging:

## CrashloopBackoff:

- What happens when you type kubectl apply -f deployment.yaml?
- What happens when the container exceeds cpu limits, memory limits?
- What is the role of an Admission controller?
- What are Mutating and validating admission controller ?
- How do you automatically monitor the instances created, in prometheus and how do you filter them?
- What happens when you type google.com? (initial lookup, final handshakes, DNS resolution etc.)
- Assume you have a webserver running locally, how do you point google.com to your local web server?
- Do you involve in building a new application to the platform?
- In K8s, what happens when a pod need more memeory, but the node doesn't have the enough capacity to scale? What happens for CPU? What happens for  the CPU intensive vs Memory intensive applications?
- In K8s, what happens when m/m usage breach the limit set and similarly CPU usage breach the limit set? (OOM and Throttling) 
- How do you troubleshoot if we get 5xx at gateway?
- Give a monitoring solution for for a platform with 50 services runing on K8s, accessing database, exposed via LB to client.
- What is your definition of incident?
- How do you measure the effectiveness of incident management?
- In-depth understanding of latencies at user end, LB end, backend etc.
- Given a scenario, where you an SRE for SaaS based firm, and the firm is interested in understanding how many calls have made for the platform, Out of these how many calls were served successfully by the platform and how many failed, how much time the platform took to serve these requests. Being an SRE, what is your idea in implementing this and how do you about designing a solution for this.
- Distributed Tracing
- Differentiate between XMX and XMS in Java application.
- In a single node cluster, there are already few deployments are running, But when you try to deploy your new application on to the same cluster, you observe that some pod eviction are happening of other deployments there by making a way for your new deployment pods. What might be the cause, how do you generally debug these kind of scenarios? (Cover cases like kube scheduler takes pod priority into consideration, older kpods started consuming more than set m/m limit and goes for OOM kill, QoS case etc.)
- Importance of Kube-Proxy in the Kubernetes architecture.
- How Service to Service Communication works inside Kubernetes?  Explain the reason for the need of service discovery/registry tools like istio, linkerd.
- Are you aware that coreDNS is responsible for the Kubernetes service discovery?
- Advantages of Karpenter over cluster autoscaler
- Concepts of reliability with detailed examples, why & how etc.
- How do you define reliability of a web application?
- How do you define the reliability of a processing engine?
- In incident management, what other aspects are important other than troubleshooting?
- What are you proud of doing in your past?
- 
- 
- Understanding of containers
- Monitoring & observability, Prometheus, Grafana (in depth), error budgets, SLIs, SLAs & SLOs concepts; HPA & Cluster Auto scaler details; what to monitor?
- Use of monitoring 4 golden signals; how to measure and how to handle them
- understanding of Infra Monitoring, synthetic monitoring & tools used; Application basic health check and deep health checks; proactive monitoring
- Chaos Engineering practices, purpose, implementation etc; chaos processes; writing custom scripts for inducing faults
- Incident Management & concepts in detail from prior experience; Incident KPIs; ability to run incidents
- Incident management protocols - driving incidents and problem management rituals
- Challenges in SRE onboarding of applications
- AWS knowledge (ASGs, EBS resiliency, replication etc.)
- K8s knowledge: HPA & VPA and their usage in application setup; explain a few metrics offered by k8s that helps monitoring availability/performance of an app running in k8s
- Python programming & problem solving (modularized code with clean code principle; Ability to research and come-up with a solution for a given problem)
- https://github.com/kilian-hu/hackerrank-solutions/blob/master/challenges/the-birthday-bar.py
- https://github.com/kilian-hu/hackerrank-solutions/blob/master/challenges/the-hurdle-race.py
- https://www.youtube.com/watch?v=xidN8ennLRs
- Basic understanding of Ci/CD, URL Uptime monitoring, using pager duty to push alerts
- K8s administration and micro services deployment
- How to's of arriving at resources request/limits for micros services
- Horizontal auto scalers. Could not suggest a solution for scale from zero.
- Taints & tolerance
- Node selectors
- Overcommitting nodes & scheduling problems
- What is needed for improving the reliability of a system?
- DevOps vs SRE
- What do you expect from Arcesium?
- Basic knowledge of HTTP & web protocols, Load balancers etc
- Identify checks & balances that can be added in a CI/CD pipeline that would prevent a problem happening after the deployment
- Give a solution for monitoring the error codes
- Linux: syslog and format and what all goes in to it; debugging questions
- Build a monitoring framework for micro service architecture
       Poll based mechanism
       Parallelism to collect metric sooner
       Horizontal scaling for high availability
       Distributed cache to achieve data consistency
#########

Here are 17 Kubernetes questions I was asked that dive into architecture, troubleshooting, and real-world decision-making:

1. Your pod keeps getting stuck in CrashLoopBackOff, but logs show no errors. How would you approach debugging and resolution?

2. You have a StatefulSet deployed with persistent volumes, and one of the pods is not recreating properly after deletion. What could be the reasons, and how do you fix it without data loss?

3. Your cluster autoscaler is not scaling up even though pods are in Pending state. What would you investigate?

4. A network policy is blocking traffic between services in different namespaces. How would you design and debug the policy to allow only specific communication paths?

5. One of your microservices has to connect to an external database via a VPN inside the cluster. How would you architect this in Kubernetes with HA and security in mind?

6. You're running a multi-tenant platform on a single EKS cluster. How do you isolate workloads and ensure security, quotas, and observability for each tenant?

7. You notice the kubelet is constantly restarting on a particular node. What steps would you take to isolate the issue and ensure node stability?

8. A critical pod in production gets evicted due to node pressure. How would you prevent this from happening again, and how do QoS classes play a role?

9. You need to deploy a service that requires TCP and UDP on the same port. How would you configure this in Kubernetes using Services and Ingress?

10. An application upgrade caused downtime even though you had rolling updates configured. What advanced strategies would you apply to ensure zero-downtime deployments next time?

11. Your service mesh sidecar (e.g., Istio Envoy) is consuming more resources than the app itself. How do you analyze and optimize this setup?

12. You need to create a Kubernetes operator to automate complex application lifecycle events. How do you design the CRD and controller loop logic?

13. Multiple nodes are showing high disk IO usage due to container logs. What Kubernetes features or practices can you apply to avoid this scenario?

14. Your Kubernetes cluster's etcd performance is degrading. What are the root causes and how do you ensure etcd high availability and tuning?

15. You want to enforce that all images used in the cluster must come from a trusted internal registry. How do you implement this at the policy level?

16. You're managing multi-region deployments using a single Kubernetes control plane. What architectural considerations must you address to avoid cross-region latency and single points of failure?

17. During peak traffic, your ingress controller fails to route requests efficiently. How would you diagnose and scale ingress resources effectively under heavy load?



You deploy on Friday afternoon and traffic drops 30% with no error alerts. Your CEO is asking questions. What’s your investigation process?

👉 Design a backup strategy for a distributed database that processes 50TB daily while maintaining ACID compliance across regions

👉 Your entire CI/CD pipeline was compromised and malicious code reached production. Walk through your containment and recovery plan

👉 Implement a deployment freeze process that can halt 200+ simultaneous deployments across teams within 60 seconds

👉 Design a resource allocation strategy where dev environments cost 80% less than production but maintain realistic testing conditions

👉 Your observability costs are 40% of your infrastructure budget. How do you optimize without losing critical visibility?

👉 Create a disaster recovery test that validates your 4-hour RTO without impacting live traffic or customer data

👉 Design a multi-tenant Kubernetes architecture where one tenant’s resource spike can’t impact others

👉 Your database replica lag hits 10 minutes during peak hours. How do you solve this without affecting write performance?

👉 Implement automated compliance scanning that prevents policy violations while maintaining developer velocity
