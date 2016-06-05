We've noted that if a domain model saves itself, using facilities provided by activerecord, then will never be able to test that object in full isolation.
在测试一个model时，多数情况下无法完全独立的去测试，需要去 load ActiveRecord and set up a database等等

We've seen that self-saves can drastically slow down test suites with needless but unavoidable writes to the database.
在测试时由于不必要但无法避免的写入数据库，导致测试速度变慢

We've seen that if business domain activities are tied to saves, adding a new pre-save validation can suddenly break dozens of tests at once. Even when the tests don't even make use of the fields being validated.
(1,2)尽管测试时没有使用到字段a，但由于字段a有validation会导致原本的测试无法通过，需要上factoryGirl等

We saw that just as with tests, batch jobs can be badly slowed down by objects which implicitly save themselves repeatedly, instead of allowing client code to save them just once at the end of a series of actions.
(batch)带有隐藏性的重复保存自己的批量任务，会大大减慢速度


We've observed how adding after-save hooks to objects which implicitly save themselves can lead to all kinds of havok, both in test and in production code.
(3)当有after_save的回调时，一旦发生错误，将很难定位

We've seen how a self-saving method might work just fine on its own—but then cause errors down the road when it is run in the context of a database transaction.
Conversely, we saw how self-saving methods might develop hidden dependencies on being run in the context of an external transaction. When the transaction is removed, they cease to work correctly.
(4,5)transaction中如果包含了后台任务，一旦发生异常，其它的都能rollback但后台任务却不会回滚

Finally, we saw how implicit saves hidden inside business logic can lead to flawed code that works "by accident", and which fails when the self-saves are removed.
(6)当有has_one或是has_many的关系时，mp通过build_waiver去创建waiver，但如果忘记self－save, 那么waiver也会丢失
