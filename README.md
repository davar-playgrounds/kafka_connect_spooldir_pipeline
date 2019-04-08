# flume_kafka
<h2>
  Diagram
</h2>
<h2>
  Requirments
</h2>
<h2>
  Tools/Services Used
</h2>
<ul>
  <li>Terraform</li>
  <li>Ansible</li>
  <li>Maven</li>
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
<h2>
  To Do
</h2>
<ul>
  <li>Change repo name to KafkaConnectSpooldir_Avro_Kafka</li>
  <li>WGET kafka-spool jar and volume to kafka-connect</li>
  <li>Modify Kafka to AutoEnable the topic creation</li>
  <li>Make a test push to Schema_Registry from Local</li>
  <li>Produce/Consume with Avro Serialization</li>
  <li>Start Kafka Connect</li>
  <li>Produce using Kafka Connect and Spooling</li>
  <li>[<b>Not a High Priority</b>] Switch to dynamic ec2 ami lookup</li>
</ul>
