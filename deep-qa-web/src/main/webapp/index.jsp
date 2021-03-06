<%--
   APDPlat - Application Product Development Platform
   Copyright (c) 2013, 杨尚川, yang-shangchuan@qq.com
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>    
<%@page import="org.apdplat.qa.model.Question"%>
<%@page import="org.apdplat.qa.model.Evidence"%>
<%@page import="org.apdplat.qa.model.CandidateAnswer"%>
<%@page import="org.apdplat.qa.model.QuestionType"%>
<%@page import="org.apdplat.qa.SharedQuestionAnsweringSystem"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    request.setCharacterEncoding("UTF-8");
    String questionStr = request.getParameter("q");
    Question question = null;
    List<CandidateAnswer> candidateAnswers = null;
    if (questionStr != null && questionStr.trim().length() > 3) {
        question = SharedQuestionAnsweringSystem.getInstance().answerQuestion(questionStr);
        if (question != null) {
            candidateAnswers = question.getAllCandidateAnswer();
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>人机问答系统演示</title>
        <script type="text/javascript">
            function answer(){
                var q = document.getElementById("q").value;
                if(q == ""){
                    return;
                }
                location.href = "index.jsp?q="+q;
            }
        </script>
    </head>
    <body>
        <h1><font color="blue">人机问答系统演示 <a href="https://github.com/ysc/QuestionAnsweringSystem" target="_blank">项目主页</a></font></h1>
                <%
                    if (questionStr == null || questionStr.trim().length() <= 3) {
                %>      
        <font color="red">请输入问题且长度大于3</font>
            <%
            } else if (candidateAnswers == null || candidateAnswers.size() == 0) {
            %>
        <font color="red">回答问题失败：<%=questionStr%></font><br/>
            <%
                }
                if (candidateAnswers != null && candidateAnswers.size() > 0) {
            %>      
        <font color="red">问题：</font><%=questionStr%><br/>
        <font color="red">答案：</font>
        <table>
            <tr><th>序号</th><th>候选答案</th><th>答案评分</th></tr>
                    <%
                        int i = 0;
                        for (CandidateAnswer candidateAnswer : candidateAnswers) {
                            if ((++i) == 1) {
                    %>			
            <tr><td><font color="red"><%=i%></font></td><td><font color="red"><%=candidateAnswer.getAnswer()%></font></td><td><font color="red"><%=candidateAnswer.getScore()%></font></td></tr>
                        <%
                        } else {
                        %>
            <tr><td><%=i%></td><td><%=candidateAnswer.getAnswer()%></td><td><%=candidateAnswer.getScore()%></td></tr>
            <%
                    }
                }
            %>        
        </table>
        <h2><a href="index.jsp">返回主页</a></h2>
        <%
        } else {
        %>
        <p>
            <b>可以像如下提问：</b><br/>
            1、APDPlat的作者是谁？<br/>
            2、APDPlat的发起人是谁？<br/>
            3、谁死后布了七十二疑冢？<br/>
            4、谁是资深Nutch搜索引擎专家？<br/>
            5、BMW是哪个汽车公司制造的？<br/>
            6、长城信用卡是哪家银行发行的？<br/>
            7、美国历史上第一所高等学府是哪个学校？<br/>
            8、前身是红色中华通讯社的是什么？<br/>
            9、“海的女儿”是哪个城市的城徽？<br/>
            10、世界上流经国家最多的河流是哪一条？<br/>
            11、世界上最长的河流是什么？<br/>
            12、汉城是哪个国家的首都？<br/>
            13、全球表面积有多少平方公里？
        </p>
        <font color="red">输入问题：</font><input id="q" name="q" size="50" maxlength="50">
        <p></p>
        <h2><a href="#" onclick="answer();">查看答案</a></h2>
        <%
            }
        %>  	
        <h2><a href="view.jsp">详细信息</a></h2>
        <br/>
        <h2><a href="history_questions.jsp">其他用户曾经问过的问题</a></h2>
    </body>
</html>