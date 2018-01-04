项目名称：easybuy
中文名称：易买网项目
项目分层：
src:.
│  
├─com        项目根目录
│  ├─emy        项目名
│  │  ├─dao        数据处理包，使用SQL语句操作数据库
│  │  │  │  PublicDao.java        数据表基础功能实现类
│  │  │  │  PublicFunctionDao.java        公共方法类
│  │  │  │  
│  │  │  ├─news        资讯包
│  │  │  │  │  NewsDao.java        资讯表功能接口类
│  │  │  │  │  
│  │  │  │  └─impl
│  │  │  │          NewsDaoImpl.java         资讯表功能实现类
│  │  │  │          
│  │  │  ├─order        订单包
│  │  │  │  │  OrderDao.java        购物车功能接口类
│  │  │  │  │  OrderDetailDao.java        订单详情功能接口类
│  │  │  │  │  
│  │  │  │  └─impl
│  │  │  │          OrderDaoImpl.java        购物车功能实现类
│  │  │  │          OrderDetailDaoImpl.java        订单详情功能实现类
│  │  │  │          
│  │  │  ├─product        商品包
│  │  │  │  │  ProductCategoryDao.java        商品分类表功能接口类
│  │  │  │  │  ProductDao.java        商品详情表功能接口类
│  │  │  │  │  
│  │  │  │  └─impl
│  │  │  │          ProductCategoryDaoImpl.java        商品分类表功能实现类
│  │  │  │          ProductDaoImpl.java        商品详情表功能实现类
│  │  │  │      
│  │  │  └─user        用户包
│  │  │      │  UserAddressDao.java        地址详情表功能接口类
│  │  │      │  UserDao.java        用户表功能接口类
│  │  │      │  
│  │  │      └─impl
│  │  │              UserAddressDaoImpl.java        地址详情表功能实现类
│  │  │              UserDaoImpl.java        用户表功能实现类
│  │  │              
│  │  ├─entity        数据表实体包
│  │  │      News.java        资讯表
│  │  │      Order.java        订单表
│  │  │      OrderDetail.java        订单详情表
│  │  │      Product.java        购物车表
│  │  │      ProductCategory.java        商品详情表
│  │  │      User.java        用户表
│  │  │      UserAddress.java        用户地址表
│  │  │      
│  │  ├─filter        过滤器包
│  │  │      FilterEncoding.java        字符编码过滤器
│  │  │      
│  │  ├─service        业务处理包
│  │  │  │  Service.java        总业务接口类
│  │  │  │  ServiceAddress.java        收货地址业务接口类
│  │  │  │  ServiceUser.java        用户功能业务接口类
│  │  │  │  
│  │  │  └─impl
│  │  │          PublicFunction.java        公共业务方法类
│  │  │          ServiceAddressImpl.java        收货地址业务实现类
│  │  │          ServiceUserImpl.java        用户功能业务实现类
│  │  │          
│  │  ├─servlet        前台页面请求任务分发包
│  │  │      Servlet_url.java        url关键字的请求业务分发类
│  │  │      
│  │  └─util        工具包
│  │          EncryptUtils.java        加密解密工具集
│  │          JsonUtil.java        FastJson工具类
│  │          Log.java        日志类
│  │          LoadConfigDatabaseUtil.java        数据库访问配置加载类
│  │          MathUtils.java        数学转换计算类
│  │          RegexUtils.java        正则表达式类
│  │          RunSQL.java        SQL语句执行类
│  │          
│  └─test
│          Test01.java
│          Test02.java
│          
└─config        配置文件
        database.properties        数据库访问配置文件
        
