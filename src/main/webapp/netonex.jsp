<div action="netonex" netonexid="netonex"
     activex32_codebase="<%=request.getContextPath()%>/netonex/NetONEX32.v1.3.7.0.cab"
     activex64_codebase="<%=request.getContextPath()%>/netonex/NetONEX64.v1.3.7.0.cab"
     npapi_codebase="<%=request.getContextPath()%>/netonex/NetONEX.v1.3.7.0.msi"
     version="1.3.7.0" logshowid="divlog">
    <!-- if activex auto installation/upgrade is reqired, at least one of the following 2 lines must be present. -->
    <object width="1" height="1" classid="CLSID:EC336339-69E2-411A-8DE3-7FF7798F8307"
            codebase="<%=request.getContextPath()%>/netonex/NetONEX32.v1.3.7.0.cab#Version=1,3,7,0"></object>
    <object width="1" height="1" classid="CLSID:EC336339-69E2-411A-8DE3-7FF7798F8307"
            codebase="<%=request.getContextPath()%>/netonex/NetONEX64.v1.3.7.0.cab#Version=1,3,7,0"></object>
</div>
<div id="divlog"></div>
<script type="text/javascript" src="<%=request.getContextPath()%>/netonex/v1370/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/netonex/v1370/jquery.sprintf.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/netonex/v1370/objectclass.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/netonex/v1370/syan.activex.src.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/netonex/v1370/netonex.base.src.js"></script>