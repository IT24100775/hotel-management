<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="pageTitle" value="Your Page Title" />
    <jsp:param name="pageSubtitle" value="Your page subtitle goes here" />
</jsp:include>

<!-- Main content -->
<div class="card">
    <div class="card-header">
        <h2>Example Content</h2>
        <p>This is a demo page showing how to use the header and footer includes</p>
    </div>
    <div class="card-body">
        <p>
            To use these includes in your JSP pages:
        </p>
        <div class="oop-concept encapsulation">
            <h3>Header Include</h3>
            <pre>
&lt;jsp:include page="../includes/header.jsp"&gt;
    &lt;jsp:param name="pageTitle" value="Your Page Title" /&gt;
    &lt;jsp:param name="pageSubtitle" value="Your page subtitle goes here" /&gt;
&lt;/jsp:include&gt;
            </pre>
        </div>
        
        <div class="oop-concept inheritance">
            <h3>Footer Include</h3>
            <pre>
&lt;jsp:include page="../includes/footer.jsp" /&gt;
            </pre>
        </div>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" /> 