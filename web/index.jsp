<%--
  Created by IntelliJ IDEA.
  User: 张志伟
  Date: 2020/12/13
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>企业信息族谱</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath }/bootstrap/js/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath }/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath }/echart/echarts.min.js"></script>
  </head>
  <body>

  <!--导航栏-->
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <!-- Brand and toggle get grouped for better mobile display -->
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">企业信息族谱 <small>V1.0</small></a>
      </div>

    </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
  </nav>
  <!--导航栏-->

  <!--页面中心内容-->
  <div class="container-fluid">

    <div class="row">
      <!--左半区-->
      <div class="col-sm-2">

        <!--菜单组件-->
        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

          <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="headingOne">
              <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                  菜单
                </a>
              </h4>
            </div>
            <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
              <div class="panel-body">
                <ul class="list-group">
                  <a class="list-group-item active" href="index.jsp">企业信息</a>
                </ul>
              </div>
            </div>
          </div>

        </div>

      </div>
      <!--左半区-->
      <%--<iframe name="hidden" style="display:none;"></iframe>--%>
      <!--中间部分-->
      <div id="content">
        <!--页面中心内容-->
        <div class="col-sm-10">
          <div>

          <form class="form-inline" target="hidden" id="searchForm">
              <div class="form-group">
                <label for="corname">公司名称</label>
                <input type="text" class="form-control" id="corname" name="corname" placeholder="公司名称">
              </div>
              <button href="${pageContext.request.contextPath}/corpServlet"   class="btn btn-default">搜索 </button>
            </form>

          <table id="showtable" class="table table-bordered table-hover">
            <tr>
              <th class="text-center">企业名称</th>
              <th class="text-center">法定代表人</th>
              <th class="text-center">操作</th>
            </tr>
            <c:forEach  items="${requestScope.pb.list}" var="cor" varStatus="s">
              <tr>
                  <td>${cor.corp_Name}</td>
                  <td>${cor.oper_Man_Name}</td>
                  <td>
                    <a onclick="show('${cor.xlfid}')"  data-toggle="modal" data-target="#showModal" class="btn btn-info">查看</a>
                    <a onclick="show1('${cor.corp_Name}')"  data-toggle="modal" data-target="#show1Modal" class="btn btn-info">股权关系</a>
                    <a onclick="show2('${cor.corp_Name}')"  data-toggle="modal" data-target="#show2Modal" class="btn btn-info">投资族谱</a>
                    <a onclick="show3('${cor.corp_Name}','${cor.oper_Man_Name}')"  data-toggle="modal" data-target="#show3Modal" class="btn btn-info">企业图谱</a>
                    <a onclick="show4('${cor.corp_Name}')"  data-toggle="modal" data-target="#show4Modal" class="btn btn-info">疑似关系</a>
                  </td>
              </tr>
            </c:forEach>
            <script>
              function show(id) {
                $.ajax({
                  type: "POST",
                  url: "showServlet",
                  data: {"id": id},
                  dataType: "json",
                  success: function (data) {
                      $("#corp_Name").html(data.corp_Name)
                      $("#addr").html(data.addr)
                      $("#web_Url").html(data.webUrl)
                      $("#email").html(data.email)
                      $("#oper_Man_Name").html(data.oper_Man_Name)
                      $("#fare_Term_Start").html(data.fare_Term_Start)
                      $("#create_Date").html(data.create_Date)
                      $("#create_Org").html(data.create_Org)
                      $("#staff_Size").html(data.staff_Size)
                      $("#prac_Person_Num").html(data.prac_Person_Num)
                      $("#belong_Org").html(data.belong_Org)
                      $("#fare_Scope").html(data.fare_Scope)

                  }
                });
              }

              function show1(corname) {
                var corpname=corname;
                var myChart = echarts.init(document.getElementById('show1'));
                var categories = [];

                categories[0] = {
                  name: '公司'
                };
                categories[1] = {
                  name: '大股东'
                };
                categories[2]={
                  name:'自然人股东'
                };
                categories[3]={
                  name:'企业股东'
                };

                option = {
                  // 图的标题
                  title: {
                    text: '企业股权关系图'
                  },
                  // 提示框的配置
                  tooltip: {
                    formatter: function (x) {
                      return x.data.des;
                    }
                  },
                  // 工具箱
                  toolbox: {
                    // 显示工具箱
                    show: true,
                    feature: {
                      mark: {
                        show: true
                      },
                      // 还原
                      restore: {
                        show: true
                      },
                      // 保存为图片
                      saveAsImage: {
                        show: true
                      }
                    }
                  },
                  legend: [{
                    // selectedMode: 'single',
                    data: categories.map(function (a) {
                      return a.name;
                    })
                  }],
                  series: [{
                    type: 'graph', // 类型:关系图
                    layout: 'force', //图的布局，类型为力导图
                    symbolSize: 40, // 调整节点的大小
                    roam: true, // 是否开启鼠标缩放和平移漫游。默认不开启。如果只想要开启缩放或者平移,可以设置成 'scale' 或者 'move'。设置成 true 为都开启
                    edgeSymbol: ['circle', 'arrow'],
                    edgeSymbolSize: [2, 10],
                    edgeLabel: {
                      normal: {
                        textStyle: {
                          fontSize: 20
                        }
                      }
                    },
                    force: {
                      repulsion: 2500,
                      edgeLength: [10, 50]
                    },
                    draggable: true,
                    lineStyle: {
                      normal: {
                        width: 2,
                        color: '#4b565b',
                      }
                    },
                    edgeLabel: {
                      normal: {
                        show: true,
                        formatter: function (x) {
                          return x.data.name;
                        }
                      }
                    },
                    label: {
                      normal: {
                        show: true,
                        textStyle: {}
                      }
                    },
                    // 数据
                    data: [],
                    links: [],
                    categories: categories,
                  }]
                };
                myChart.setOption(option);

                var datas=[];
                var links=[];
                tmp={name:corpname,des:"公司",symbolSize: 70, category:0};
                datas.push(tmp);
                $.ajax({
                  type: "POST",
                  url: "show1Servlet",
                  data: {"corname": corname},
                  dataType: "json",
                  success: function (data) {
                    for (var i=0;i<data.length;i++)
                    {
                      if(data[i].type=="大股东")
                      {
                        tmp={name:data[i].username,des:"股权比例："+data[i].bili+" 认缴金额："+data[i].money,symbolSize: 50, category:1};
                        datas.push(tmp);
                        tmp2={source:data[i].username,target:corpname,name:'大股东',des:"大股东"};
                        links.push(tmp2);
                      }
                      else if(data[i].type=="自然人股东")
                      {
                        tmp={name:data[i].username,des:"股权比例："+data[i].bili+" 认缴金额："+data[i].money,symbolSize: 50, category:2};
                        datas.push(tmp);
                        tmp2={source:data[i].username,target:corpname,name:'自然人股东',des:"自然人股东"};
                        links.push(tmp2);
                      }
                      else if(data[i].type=="企业股东")
                      {
                        tmp={name:data[i].username,des:"股权比例："+data[i].bili+" 认缴金额："+data[i].money,symbolSize: 50, category:3};
                        datas.push(tmp);
                        tmp2={source:data[i].username,target:corpname,name:'企业股东',des:'企业股东'};
                        links.push(tmp2);
                      }
                    }
                    myChart.setOption({
                      series:[{
                        data:datas,
                        links:links
                      }]
                    });

                  }
                });
              }

              function show2(corname) {
                var corpname=corname;
                var myChart2 = echarts.init(document.getElementById('show2'));
                var categories = [];

                categories[0] = {
                  name: '公司'
                };
                categories[1] = {
                  name: '股东'
                };
                categories[2]={
                  name:'对外投资'
                };

                option = {
                  // 图的标题
                  title: {
                    text: '企业投资关系图'
                  },
                  // 提示框的配置
                  tooltip: {
                    formatter: function (x) {
                      return x.data.des;
                    }
                  },
                  // 工具箱
                  toolbox: {
                    // 显示工具箱
                    show: true,
                    feature: {
                      mark: {
                        show: true
                      },
                      // 还原
                      restore: {
                        show: true
                      },
                      // 保存为图片
                      saveAsImage: {
                        show: true
                      }
                    }
                  },
                  legend: [{
                    // selectedMode: 'single',
                    data: categories.map(function (a) {
                      return a.name;
                    })
                  }],
                  series: [{
                    type: 'graph', // 类型:关系图
                    layout: 'force', //图的布局，类型为力导图
                    symbolSize: 40, // 调整节点的大小
                    roam: true, // 是否开启鼠标缩放和平移漫游。默认不开启。如果只想要开启缩放或者平移,可以设置成 'scale' 或者 'move'。设置成 true 为都开启
                    edgeSymbol: ['circle', 'arrow'],
                    edgeSymbolSize: [2, 10],
                    edgeLabel: {
                      normal: {
                        textStyle: {
                          fontSize: 20
                        }
                      }
                    },
                    force: {
                      repulsion: 2500,
                      edgeLength: [10, 50]
                    },
                    draggable: true,
                    lineStyle: {
                      normal: {
                        width: 2,
                        color: '#4b565b',
                      }
                    },
                    edgeLabel: {
                      normal: {
                        show: true,
                        formatter: function (x) {
                          return x.data.name;
                        }
                      }
                    },
                    label: {
                      normal: {
                        show: true,
                        textStyle: {}
                      }
                    },
                    // 数据
                    data: [],
                    links: [],
                    categories: categories,
                  }]
                };
                myChart2.setOption(option);

                var datas=[];
                var links=[];
                tmp={name:corpname,des:"公司",symbolSize: 70, category:0};
                datas.push(tmp);
                tmp2={name:"股东",des:"股东",symbolSize: 50, category:1};
                tmp3={name:"对外投资",des:"对外投资",symbolSize: 50, category:2};
                datas.push(tmp2);
                datas.push(tmp3);
                tmpl={source:corpname,target:"股东",name:'股东'};
                tmpl2={source:corpname,target:"对外投资",name:'投资'};
                links.push(tmpl);
                links.push(tmpl2);
                $.ajax({
                  type: "POST",
                  url: "show1Servlet",
                  data: {"corname": corname},
                  dataType: "json",
                  success: function (data) {
                    for (var i=0;i<data.length;i++)
                    {
                      tmp={name:data[i].username,des:"股权比例："+data[i].bili+" 认缴金额："+data[i].money,symbolSize: 50, category:1};
                      datas.push(tmp);
                      tmp2={source:"股东",target:data[i].username,name:data[i].bili,des:data[i].bili};
                      links.push(tmp2);
                    }
                    $.ajax({
                      type: "POST",
                      url: "show2Servlet",
                      data: {"corname": corname},
                      dataType: "json",
                      success: function (data) {
                        for (var i=0;i<data.length;i++)
                        {
                          tmp={name:data[i].tcompany,des:"投资比例："+data[i].bili+" 投资金额："+data[i].money,symbolSize: 50, category:2};
                          datas.push(tmp);
                          tmp2={source:"对外投资",target:data[i].tcompany,name:data[i].bili,des:data[i].bili};
                          links.push(tmp2);
                        }
                        myChart2.setOption({
                          series:[{
                            data:datas,
                            links:links
                          }]
                        });
                      }});


                  }
                });
              }

              function show3(corname,oper_Man_Name) {
                var corpname=corname;
                var myChart3 = echarts.init(document.getElementById('show3'));
                var categories = [];

                categories[0] = {
                  name: '公司'
                };
                categories[1] = {
                  name: '股东'
                };
                categories[2]={
                  name:'对外投资'
                };
                categories[3]={
                  name:'高管'
                };
                categories[4]={
                  name:'裁判文书'
                };
                categories[5]={
                  name:'法定代表'
                };
                categories[6]={
                  name:'历史股东'
                };
                categories[7]={
                  name:'法院公告'
                };

                option = {
                  // 图的标题
                  title: {
                    text: '企业图谱'
                  },
                  // 提示框的配置
                  tooltip: {
                    formatter: function (x) {
                      return x.data.des;
                    }
                  },
                  // 工具箱
                  toolbox: {
                    // 显示工具箱
                    show: true,
                    feature: {
                      mark: {
                        show: true
                      },
                      // 还原
                      restore: {
                        show: true
                      },
                      // 保存为图片
                      saveAsImage: {
                        show: true
                      }
                    }
                  },
                  legend: [{
                    // selectedMode: 'single',
                    data: categories.map(function (a) {
                      return a.name;
                    })
                  }],
                  series: [{
                    type: 'graph', // 类型:关系图
                    layout: 'force', //图的布局，类型为力导图
                    symbolSize: 40, // 调整节点的大小
                    roam: true, // 是否开启鼠标缩放和平移漫游。默认不开启。如果只想要开启缩放或者平移,可以设置成 'scale' 或者 'move'。设置成 true 为都开启
                    edgeSymbol: ['circle', 'arrow'],
                    edgeSymbolSize: [2, 10],
                    edgeLabel: {
                      normal: {
                        textStyle: {
                          fontSize: 20
                        }
                      }
                    },
                    force: {
                      repulsion: 2500,
                      edgeLength: [10, 50]
                    },
                    draggable: true,
                    lineStyle: {
                      normal: {
                        width: 2,
                        color: '#4b565b',
                      }
                    },
                    edgeLabel: {
                      normal: {
                        show: true,
                        formatter: function (x) {
                          return x.data.name;
                        }
                      }
                    },
                    label: {
                      normal: {
                        show: true,
                        textStyle: {}
                      }
                    },
                    // 数据
                    data: [],
                    links: [],
                    categories: categories,
                  }]
                };
                myChart3.setOption(option);

                var datas=[];
                var links=[];

                tmp={name:corpname,des:"公司",symbolSize: 70, category:0};
                datas.push(tmp);
                tmp2={name:"股东",des:"股东",symbolSize: 50, category:1};
                tmp3={name:"对外投资",des:"对外投资",symbolSize: 50, category:2};
                tmp4={name:"高管",des:"高管",symbolSize: 50, category:3};
                tmp5={name:"裁判文书",des:"裁判文书",symbolSize: 50, category:4};
                tmp6={name:"法定代表",des:"法定代表",symbolSize: 50, category:5};
                tmp7={name:"历史股东",des:"历史股东",symbolSize: 50, category:6};
                tmp8={name:"法院公告",des:"法院公告",symbolSize: 50, category:7};

                tmp9={name:oper_Man_Name,des:"法定代表",symbolSize:50,category:5};
                datas.push(tmp2);
                datas.push(tmp3);
                datas.push(tmp4);
                datas.push(tmp5);
                datas.push(tmp6);
                datas.push(tmp7);
                datas.push(tmp8);
                datas.push(tmp9);
                tmpl={source:corpname,target:"股东",name:'股东'};
                tmpl2={source:corpname,target:"对外投资",name:'投资'};
                tmpl3={source:corpname,target:"高管",name:'高管'};
                tmpl4={source:corpname,target:"裁判文书",name:'裁判文书'};
                tmpl5={source:corpname,target:"法定代表",name:'法定代表'};
                tmpl6={source:corpname,target:"历史股东",name:'历史股东'};
                tmpl7={source:corpname,target:"法院公告",name:'法院公告'};
                tmpl8={source:"法定代表",target:oper_Man_Name,name:'代表'};

                links.push(tmpl);
                links.push(tmpl2);
                links.push(tmpl3);
                links.push(tmpl4);
                links.push(tmpl5);
                links.push(tmpl6);
                links.push(tmpl7);
                links.push(tmpl8);
                $.ajax({
                  type: "POST",
                  url: "show1Servlet",
                  data: {"corname": corname},
                  dataType: "json",
                  success: function (data) {
                    for (var i=0;i<data.length;i++)
                    {
                      tmp={name:data[i].username,des:"股权比例："+data[i].bili+" 认缴金额："+data[i].money,symbolSize: 50, category:1};
                      datas.push(tmp);
                      tmp2={source:"股东",target:data[i].username,name:data[i].bili,des:data[i].bili};
                      links.push(tmp2);
                    }

                    $.ajax({
                      type: "POST",
                      url: "show2Servlet",
                      data: {"corname": corname},
                      dataType: "json",
                      success: function (data) {
                        for (var i=0;i<data.length;i++)
                        {
                          tmp={name:data[i].tcompany,des:"投资比例："+data[i].bili+" 投资金额："+data[i].money,symbolSize: 50, category:2};
                          datas.push(tmp);
                          tmp2={source:"对外投资",target:data[i].tcompany,name:data[i].bili,des:data[i].bili};
                          links.push(tmp2);
                        }
                        myChart3.setOption({
                          series:[{
                            data:datas,
                            links:links
                          }]
                        });
                      }
                    });

                  }
                });

              }

              function show4(corname) {
                var corpname=corname;
                var myChart4 = echarts.init(document.getElementById('show4'));
                var categories = [];

                categories[0] = {
                  name: '公司'
                };
                categories[1] = {
                  name: '相关人员'
                };

                option = {
                  // 图的标题
                  title: {
                    text: '疑似关系'
                  },
                  // 提示框的配置
                  tooltip: {
                    formatter: function (x) {
                      return x.data.des;
                    }
                  },
                  // 工具箱
                  toolbox: {
                    // 显示工具箱
                    show: true,
                    feature: {
                      mark: {
                        show: true
                      },
                      // 还原
                      restore: {
                        show: true
                      },
                      // 保存为图片
                      saveAsImage: {
                        show: true
                      }
                    }
                  },
                  legend: [{
                    // selectedMode: 'single',
                    data: categories.map(function (a) {
                      return a.name;
                    })
                  }],
                  series: [{
                    type: 'graph', // 类型:关系图
                    layout: 'force', //图的布局，类型为力导图
                    symbolSize: 40, // 调整节点的大小
                    roam: true, // 是否开启鼠标缩放和平移漫游。默认不开启。如果只想要开启缩放或者平移,可以设置成 'scale' 或者 'move'。设置成 true 为都开启
                    edgeSymbol: ['circle', 'arrow'],
                    edgeSymbolSize: [2, 10],
                    edgeLabel: {
                      normal: {
                        textStyle: {
                          fontSize: 20
                        }
                      }
                    },
                    force: {
                      repulsion: 2500,
                      edgeLength: [10, 50]
                    },
                    draggable: true,
                    lineStyle: {
                      normal: {
                        width: 2,
                        color: '#4b565b',
                      }
                    },
                    edgeLabel: {
                      normal: {
                        show: true,
                        formatter: function (x) {
                          return x.data.name;
                        }
                      }
                    },
                    label: {
                      normal: {
                        show: true,
                        textStyle: {}
                      }
                    },
                    // 数据
                    data: [],
                    links: [],
                    categories: categories,
                  }]
                };
                myChart4.setOption(option);

                var datas=[];
                var links=[];

                tmp={name:corpname,des:"公司",symbolSize: 70, category:0};
                datas.push(tmp);

                $.ajax({
                  type: "POST",
                  url: "show4Servlet",
                  data: {"corname": corname},
                  dataType: "json",
                  success: function (data) {
                    var a=new Map();

                    for (var i=0;i<data.length;i++)
                    {
                      if(a.get(data[i].username)==null)
                      {
                        tmp={name:data[i].username,des:data[i].username,symbolSize: 50, category:1};
                        datas.push(tmp);
                        a.set(data[i].username,1);
                      }
                      if(data[i].corpname!==corpname)
                      {
                        tmp3={name:data[i].corpname,des:data[i].corpname,symbolSize: 50, category:0};
                        datas.push(tmp3);
                      }
                      tmp2={source:data[i].username,target:data[i].corpname,name:data[i].type,des:data[i].type};
                      links.push(tmp2);
                    }
                    myChart4.setOption({
                      series:[{
                        data:datas,
                        links:links
                      }]
                    });
                  }
                });
              }

            </script>


          </table>



        </div>
      </div>
    </div>
  </div>
  </div>
  <!--页面中心内容-->

  <!--页面底部-->
  <footer class="footer navbar-fixed-bottom ">
    <div class="container">
      <!--分页工具栏-->
      <div class=" text-center" >
        <nav aria-label="Page navigation">
          <ul class="pagination">
            <c:if test="${requestScope.pb.currentPage == 1}">
            <li class="disabled">
              </c:if>

              <c:if test="${requestScope.pb.currentPage != 1}">
            <li>
              </c:if>


              <a href="${pageContext.request.contextPath}/corpServlet?currentPage=${pb.currentPage - 1}&rows=10" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
              </a>
            </li>

            <c:if test="${requestScope.pb.totalPage>=10}" >
              <!-- 当前页数小于等于4时，显示1到5...最后一页 -->
              <c:if test="${pb.currentPage<=4}">
                <c:forEach begin="1" end="5" var="i">
                  <li <c:if test="${requestScope.pb.currentPage==i }">class="active"</c:if>>
                    <a href="${pageContext.request.contextPath}/corpServlet?currentPage=${i}&rows=10">${i}</a>
                  </li>
                </c:forEach>
                <li><a href="#">...</a></li>
                <li
                        <c:if test="${requestScope.pb.currentPage==requestScope.pb.totalPage }">class="active"</c:if>>
                  <a href="${pageContext.request.contextPath}/corpServlet?currentPage=${requestScope.pb.totalPage}&rows=10">${pb.totalPage}</a>
                </li>
              </c:if>
              <!-- 当前页数大于4时，如果当前页小于总页码书-3，则显示1...n-1,n,n+1...最后一页 -->
              <c:if test="${pb.currentPage>4}">
                <c:if test="${pb.currentPage<(pb.totalPage-3)}">
                  <li><a href="${pageContext.request.contextPath}/corpServlet?currentPage=${1}&rows=10">${1}</a>
                  </li>
                  <li><a href="#">...</a></li>
                  <c:forEach begin="${requestScope.pb.currentPage-1 }" end="${requestScope.pb.currentPage+1 }" var="i">
                    <li <c:if test="${requestScope.pb.currentPage==i }">class="active"</c:if>>
                      <a href="${pageContext.request.contextPath}/corpServlet?currentPage=${i}&rows=10">${i}</a>
                    </li>
                  </c:forEach>
                  <li><a href="#">...</a></li>
                  <li
                          <c:if test="${requestScope.pb.currentPage==requestScope.pb.totalPage }">class="active"</c:if>>
                    <a href="${pageContext.request.contextPath}/corpServlet?currentPage=${requestScope.pb.totalPage}&rows=10">${pb.totalPage}</a>
                  </li>
                </c:if>
              </c:if>
              <!-- 当前页数大于4时，如果当前页大于总页码书-4，则显示1...最后一页-3，最后一页-2，最后一页-1，最后一页 -->
              <c:if test="${requestScope.pb.currentPage>requestScope.pb.totalPage-4}">
                <li><a href="${pageContext.request.contextPath}/corpServlet?currentPage=${1}&rows=10">${1}</a>
                </li>
                <li><a href="#">...</a></li>
                <c:forEach begin="${requestScope.pb.totalPage-3 }"  end="${requestScope.pb.totalPage }" var="i">
                  <li <c:if test="${requestScope.pb.currentPage==i }">class="active"</c:if>>
                    <a href="${pageContext.request.contextPath}/corpServlet?currentPage=${i}&rows=10">${i}</a>
                  </li>
                </c:forEach>
              </c:if>
            </c:if>

            <c:if test="${requestScope.pb.totalPage<10}"    >
              <c:forEach begin="1" end="${requestScope.pb.totalPage}" var="i" >
                <c:if test="${requestScope.pb.currentPage == i}">
                  <li class="active"><a href="${pageContext.request.contextPath}/corpServlet?currentPage=${i}&rows=10">${i}</a></li>
                </c:if>
                <c:if test="${requestScope.pb.currentPage != i}">
                  <li><a href="${pageContext.request.contextPath}/corpServlet?currentPage=${i}&rows=10">${i}</a></li>
                </c:if>

              </c:forEach>
            </c:if>

            <c:if test="${requestScope.pb.currentPage == requestScope.pb.totalPage}">
            <li class="disabled">
              </c:if>
              <c:if test="${requestScope.pb.currentPage != requestScope.pb.totalPage}">
            <li>
              </c:if>
              <a href="${pageContext.request.contextPath}/corpServlet?currentPage=${requestScope.pb.currentPage + 1}&rows=10" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
              </a>
            </li>
            <span style="font-size: 25px;margin-left: 5px;">
                        共<span style="color: deepskyblue">${requestScope.pb.totalCount}</span>条记录，共<span style="color: deepskyblue">${requestScope.pb.totalPage}</span>页
                </span>
          </ul>
        </nav>
      </div>
    </div>

  </footer>

  <!--添加用户的对话框-->
  <div class="modal fade " id="showModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">公司信息</h4>
        </div>
        <table class="table table-hover table-bordered">
            <tr>
              <td>企业名称</td>
              <td><span id="corp_Name"></span></td>
              <td>企业地址</td>
              <td><span id="addr"></span></td>
            </tr>
          <tr>
            <td>官网</td>
            <td><span id="web_Url"></span></td>
            <td>邮箱</td>
            <td><span id="email"></span></td>
          </tr>
          <tr>
            <td>法定代表人名称</td>
            <td><span id="oper_Man_Name"></span></td>
            <td>经营期限（起）</td>
            <td><span id="fare_Term_Start"></span></td>
          </tr>
          <tr>
            <td>创建时间</td>
            <td><span id="create_Date"></span></td>
            <td>创建机构代码</td>
            <td><span id="create_Org"></span></td>
          </tr>
          <tr>
            <td>人员规模</td>
            <td><span id="staff_Size"></span></td>
            <td>从业人数</td>
            <td><span id="prac_Person_Num"></span></td>
          </tr>
          <tr>
            <td>所属行业</td>
            <td><span id="belong_Org"></span></td>
            <td>经营范围</td>
            <td><span id="fare_Scope"></span></td>
          </tr>
        </table>

      </div>
    </div>
  </div>

  <div class="modal fade " id="show1Modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">股份信息</h4>
        </div>
        <div id="show1" style="height:400px;width: 800px;padding: 20px" ></div>
        <script>

        </script>

      </div>
    </div>
  </div>

  <div class="modal fade " id="show2Modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">投资族谱</h4>
        </div>
        <div id="show2" style="height:400px;width: 800px;padding: 20px" ></div>
        <script>

        </script>

      </div>
    </div>
  </div>

  <div class="modal fade " id="show3Modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">企业图谱</h4>
        </div>
        <div id="show3" style="height:400px;width: 800px;padding: 20px" ></div>
        <script>

        </script>

      </div>
    </div>
  </div>

  <div class="modal fade " id="show4Modal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">疑似关系</h4>
        </div>
        <div id="show4" style="height:400px;width: 800px;padding: 20px" ></div>
        <script>

        </script>

      </div>
    </div>
  </div>



  </body>
</html>
