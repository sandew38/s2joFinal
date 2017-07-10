<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- SWAL -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css"
        rel="stylesheet">
<script src=" https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.common.min.js"></script>
<link rel="stylesheet" href="dist/sweetalert.css">
<link rel="stylesheet" href="themes/twitter/twitter.css">

<script type="text/javascript">
	alert("${msg}");
	location.href="${loc}";
	self.close(); 
	
	
 </script>    