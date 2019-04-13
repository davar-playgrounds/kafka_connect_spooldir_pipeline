# kafka_connect_spooldir_pipeline
<h2>
  Diagram
</h2>

![alt text](https://github.com/tigstep/flume_kafka/blob/master/diagrams/kafka_connect_spooldir.jpg)
<h2>
  Requirments
</h2>
<h2>
  Tools/Services Used
</h2>
<ul>
  <li>Terraform</li>
  <li>Ansible</li>
  <li>Apache Maven</li>
  <li>AWS EC2</li>
  <li>Confluent Kafka</li>
    <ul>
      <li>Zookeeper</li>
      <li>Kafka Broker</li>
      <li>Schema Registry</li>
      <li>Control Center</li>
      <li>Kafka Connect Worker</li>
    </ul>
  <li>Docker</li>
  <li>Kafka-Connect-Spooldir Connector</li>
</ul>
<h2>
  Short Description
</h2>
A dockerized Confluent Kafka Cluster running on AWS EC2 instances that uses the Spooldir Connector(https://github.com/jcustenborder/kafka-connect-spooldir) to spool a directory, Avro serialize the data using the Schema Registry and publish to Kafka Brokers. This project also makes the Confluent Control Center available for visualization.  
<h2>
  Process Description
</h2>
This project uses two different infrasctructure managment tools to prepare the infrastructure (Terraform and Ansible)
    <h3>
      Terraform
    </h3>
    <ol>
      <li>Creates a VPC</li>
      <li>Creates a Subnet inside that VPC</li>
      <li>Defines a Security Group for later use</li>
      <li>Defines an Internet Gatway and Configures the routing to use the Internet Gateway</li>
      <li>Spins up ec2 instances inside the Subnet created above behind the defined Security Group</li>
    </ol>
    <h3>
      Ansible
    </h3>
  <ol>
    <li>Installs Docker on the above EC2 instances</li>
    <li>Starts the a Zookeeper Container using Confluent's Zookeeper Image</li>
    <li>Starts the a Kafka Container using Confluent's Enterprise Kafka Image</li>
    <li>On one of the EC2 instances it starts a Schema Registry Container using Confluent's Schema Registry Image</li>
    <li>On one of the EC2 instances it starts a Control Center Container using Confluent's Enterprise Control Center Image</li>
    <li>On one of the EC2 instances it starts a Kafka Connect Container using Confluent's Kafka Connect Image and adds Kafka_Connect_Spooldir connector in it's path</li>
  </ol>
<h2>
  To Do
</h2>
<ul>
  <li>Modify Kafka to AutoEnable the topic creation</li>
  <li>Make Kafka Connect Topic Visible in Control Center</li>
  <li>[<b>Not a High Priority</b>] Switch to dynamic ec2 ami lookup</li>
</ul>
<h2>
  Execution
</h2>
  In order to execute, issue
  <ol>
    <li>terraform apply -var-file=variables.tfvars && terraform output  ec2_ips > output.txt</li>
    <li>ansible-playbook ansible.yml</li>
  </ol>
  The above 2 steps should provide a fully functional pipeline that will take a CSV files as an input, avro serialize it and publish to a topic.
<h2>
  Test run
</h2>
  In order to test the pipeline,
  Copy the file provided to /tmp/.. location on the EC2 instance where the Kafka Connect Container is running.
  You should be able to see the topic populated using Either the Control Center or kafka consumer
<h2>
Observations
</h2>
<ul>
  <li>It would be very useful to have a central repository of kafka connect connectors that can be accessed programaticaly to download and place the connectors onto connect worker's path</li>
</ul>
<h2>
  Warnings
</h2>
<ul>
  <li>Current configuration of this project will be using AWS services that are beyond the Free Tier!</li>
</ul>
