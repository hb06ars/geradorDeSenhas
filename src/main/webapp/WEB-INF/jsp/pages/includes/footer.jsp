<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


</div> <!-- container -->
                               
                </div> <!-- content -->

                <footer class="footer">
                    <span id="dataHoje"> </span>
                </footer>

            </div>
            <!-- ============================================================== -->
            <!-- End Right content here -->
            <!-- ============================================================== -->




        </div>
        <!-- END wrapper -->
        
        <!-- MODAIS -->
		<jsp:include page="modal.jsp" />
		<!--  ATUALIZAR PÁGINA  -->
		<c:if test="${atualizarPagina != null }">
			<script>window.location.href='${atualizarPagina}';</script>
		</c:if>
		<!--  FIM ATUALIZAR PÁGINA  -->
		<!--  ERRO  -->
		<c:if test="${erro != null}">
			<div class="alert alert-danger">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
				<strong>Erro!</strong><br>${erro }
			</div>
		</c:if>
		<!--  FIM ERRO  -->
					
 
    
        <script>
            var resizefunc = [];
        </script>

        <!-- jQuery  -->
        <script src="/assets/js/jquery.min.js"></script>
        <script src="/assets/js/bootstrap.min.js"></script>
        <script src="/assets/js/detect.js"></script>
        <script src="/assets/js/fastclick.js"></script>
        <script src="/assets/js/jquery.slimscroll.js"></script>
        <script src="/assets/js/jquery.blockUI.js"></script>
        <script src="/assets/js/waves.js"></script>
        <script src="/assets/js/wow.min.js"></script>
        <script src="/assets/js/jquery.nicescroll.js"></script>
        <script src="/assets/js/jquery.scrollTo.min.js"></script>


        <script src="/assets/js/jquery.core.js"></script>
        <script src="/assets/js/jquery.app.js"></script>

        <script src="/assets/plugins/jquery-ui/jquery-ui.min.js"></script>

        <!-- BEGIN PAGE SCRIPTS -->
        <script src="/assets/plugins/moment/moment.js"></script>
        <script src="/assets/plugins/fullcalendar/js/fullcalendar.min.js"></script>
        <script src="/assets/pages/jquery.fullcalendar.js"></script>

	
	</body>
</html>