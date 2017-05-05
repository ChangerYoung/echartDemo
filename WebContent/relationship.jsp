<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="echarts.min.js"></script>
<script src="jquery.js"></script>
<link rel="stylesheet" href="bootstrap.min.css" rel="stylesheet"/>
<script type="text/javascript" src="bootstrap.min.js" ></script>
<title>武器装备关系图</title>
</head>
<body>
	<h2>装备区</h2>
		<ul class="nav nav-tabs">
		  <li><a href="#">发动机</a></li>
		  <li><a href="#">导弹</a></li>
		  <li><a href="#">机型</a></li>
		</ul>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="width:900px;height:800px; border: solid;margin-left: auto;margin-right: auto;"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        myChart.showLoading();
		$.getJSON('npmdepgraph.json', function (json) {
    	myChart.hideLoading();
    	myChart.setOption(option = {
        title: {
            text: '装备关系图'
        },
        textAlign:'left',
        //动画更新时常
        animationDurationUpdate: 1500,
        animationEasingUpdate: 'quinticInOut',
        series : [
            {
                type: 'graph',
                layout: 'none',
                hoverAnimation:true,
                // progressiveThreshold: 700,
                data: json.nodes.map(function (node) {
                    return {
                        x: node.x,
                        y: node.y,
                        id: node.id,
                        name: node.label,
                        symbolSize: node.size,
                        itemStyle: {
                            normal: {
                                color: node.color
                            }
                        }
                    };
                }),
                //边的设置
                edges: json.edges.map(function (edge) {
                    return {
                        source: edge.sourceID,
                        target: edge.targetID,
                        lineStyle: {
                            normal: {
                                width: 0.5,
                                color:'#ff0000',
                                curveness: 0.2,
                                opacity: edge.opacity==0?0:1
                            },
                            emphasis:{
                            	width: 0.5,
                                color:'#000',
                                curveness: 0.3,
                                opacity: edge.opacity==0?0:1
                            }
                        }
                    };
                }),
                //图形字体的备注
                label: {
                	normal:{
                		show:true,
                		position:'inside'
                	},
                    emphasis: {
                        position: 'inside',
                        show: true
                    }
                },
                roam: true,//开启缩放平移，可以关闭或设置为 'scale' or 'move'
               // focusNodeAdjacency: true//是否在鼠标移到节点上的时候突出显示节点以及节点的边和邻接节点
                //layout:'circular'
            }
        ]
    }, true);
});
		//var option2=[];
		/*for(int i=0;i<option.length;i++)
			{
				option2[i]=option[i];
			}*/
		//option2=option;
		//var option2=option;
		myChart.on('mouseover', function (params) {
		    if (params.componentType === 'series') {
		        if (params.seriesType === 'graph') {
		            if (params.name === '歼7') { // 点击到了 graph 的 edge（边）上。
		            	var edgesIndex = [0,1,2,3,13,26,6,32,8,9];
		            	var dataIndex = [0,1,2,8,9,18,30,29,26,7,19];
		            	//修改关联节点的颜色
		            	for(var i=0;i<dataIndex.length;i++)
		            	{
		            		var j=dataIndex[i];
		            		option.series[0].data[j].itemStyle.normal.color='#6495ED';
		            	}
		            	//修改边的颜色和曲度
		            	for(var i=0;i<edgesIndex.length;i++)
	            		{
	            			var j=edgesIndex[i];
	            			option.series[0].edges[j].lineStyle.normal.color='#6495ED';
		            		option.series[0].edges[j].lineStyle.normal.curveness=0.5;
	            		}
		            	myChart.setOption(option);
		            	myChart.dispatchAction({
		    			    type: 'highlight',
		    			    edgeIndex: 1,
		    			    name:['装备','机型','导弹','发动机','雷达','战斗机','WP-5','搜索雷达','地空导弹','PL-9']
		    			});
		            	
		            }
		            else {
		                // 点击到了 graph 的 node（节点）上。
		            	
		            }
		        }
		    }

		});
			myChart.on('mouseout', function (params) {
				if (params.componentType === 'series') {
			        if (params.seriesType === 'graph') {
			            if (params.name === '歼7') { // 点击到了 graph 的 edge（边）上。
			            	var edgesIndex = [0,1,2,3,13,26,6,32,8,9];
			            	var dataIndex = [[0],[1,30,31,32,33],[9,10,14,18,19,20,21,11,12,13,15,16,17],[8,22,26,23,24,25,27,28,29],[2,3,4,5,6,7]];
			            	//返回关联节点的颜色
			            	for(var i=0;i<dataIndex[0].length;i++)
			            	{
			            		var j=dataIndex[0][i];
			            		option.series[0].data[j].itemStyle.normal.color='#1984c7';
			            	}
			            	for(var i=0;i<dataIndex[1].length;i++)
			            	{
			            		var j=dataIndex[1][i];
			            		option.series[0].data[j].itemStyle.normal.color='#4f19c7';
			            	}
			            	for(var i=0;i<dataIndex[2].length;i++)
			            	{
			            		var j=dataIndex[2][i];
			            		option.series[0].data[j].itemStyle.normal.color='#c74f19';
			            	}
			            	for(var i=0;i<dataIndex[3].length;i++)
			            	{
			            		var j=dataIndex[3][i];
			            		option.series[0].data[j].itemStyle.normal.color='#c71969';
			            	}
			            	for(var i=0;i<dataIndex[4].length;i++)
			            	{
			            		var j=dataIndex[4][i];
			            		option.series[0].data[j].itemStyle.normal.color='#9f19c7';
			            	}
			            	//返回边的颜色和曲度
			            	for(var i=0;i<edgesIndex.length;i++)
		            		{
		            			var j=edgesIndex[i];
		            			option.series[0].edges[j].lineStyle.normal.color='#ff0000';
			            		option.series[0].edges[j].lineStyle.normal.curveness=0.2;
		            		}
			            	myChart.setOption(option);
			            	myChart.dispatchAction({
			    			    type: 'downplay',
			    			    edgeIndex: 1,
			    			    name:['装备','机型','导弹','发动机','雷达','战斗机','WP-5','搜索雷达','地空导弹','PL-9']
			    			});
			            	
			            }
			            else {
			                // 点击到了 graph 的 node（节点）上。
			            	
			            }
			        }
			    }
			});
        // 使用刚指定的配置项和数据显示图表。
      // myChart.setOption(option);
        </script>
</body>
</html>