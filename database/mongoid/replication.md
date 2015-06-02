### Master-salve replication(主从复制－－不再推荐)
* master节点能进行任何数据操作
* slave节点职能读取从master节点同步过来的数据，不能进行数据的更新删除
* 出故障时需要停机操作，将slave切换为master


### Replica Sets(复制集)
有自动故障恢复功能的主从集群，若其中的一个节点出现故障，其他节点马上会将业务接过来，而无需停机操作

##### oplog
MongoDB 的复制集是通过 Oplog 来实现的，主库的更改操作会被记录到主库的 Oplog 日志中，然后从库通过异步方式复制主库的 Oplog 文件并且将 Oplog 日志应用到从库，从而实现了与主库的同步。

##### heartbeat
the heartbeat monitors health and triggers failover


* http://blog.jobbole.com/72624/
* http://blog.jobbole.com/72636/
* http://blog.jobbole.com/72643/
* http://blog.nosqlfan.com/html/4139.html
