<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<!-- list page -->
	<!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">게시판</h1>
          <p class="mb-4">자유게시판</p>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">게시글</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>글번호</th>
                      <th>글제목</th>
                      <th>작성자</th>
                      <th>조회수</th>
                      <th>작성일</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:if test="${empty list}">
                  	<tr>
                  		<td colspan="5" class="text-center"><h3>게시글이 없습니다.</h3></td>
                  	</tr>
                  </c:if>
                  <c:if test="${!empty list}">
                  <c:forEach var="dto" items="${list}">
                  	<tr>
                  		<td>${dto.fno }</td>
                  		<td align="center"><a href="#">${dto.subject }</a></td>
                  		<td>${dto.mid}</td>
                  		<td>${dto.hit }</td>
                  		<td align="center"><fmt:formatDate type="date" value="${dto.f_indate}"/></td>
                  	</tr>
                  </c:forEach>
                  </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          		 <nav class="blog-pagination justify-content-center d-flex">
                          <ul class="pagination">
                          		<c:if test="${pageMaker.prev}">
                          			<li class="page-item">
                                  <a href="${pageMaker.startPage -1}" class="page-link pageN" aria-label="Previous">
                                      <span aria-hidden="true">
                                          <span class="lnr lnr-chevron-left"></span>
                                      </span>
                                  </a>
                              </li>
                          		</c:if>
                          	
                              <c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}">
								
								<li class='page-item  ${pageMaker.startDTO.page == num ? "active":""} '>
									<a href="${num}" class="page-link pageN">${num}</a>
								</li>
								
							</c:forEach>
                              
                               <c:if test="${pageMaker.next}">
									<li class="page-item">
	                                  <a href="${pageMaker.endPage +1 }" class="page-link pageN" aria-label="Next">
	                                      <span aria-hidden="true">
	                                          <span class="lnr lnr-chevron-right"></span>
	                                      </span>
	                                  </a>
	                              </li>
								</c:if>
								
                          </ul>
                      </nav>

				<!--  end Pagination -->

        </div>
        <!-- /.container-fluid -->
        <form id="pkc" name="pkc" method="get" action="${ctxpath}/boards/list">
        	<input type="hidden" name="page">
        	<input type="hidden" name="amount" value="10">
        	<input type="hidden" name="startRecord">
        </form>

<%@ include file="../include/footer.jsp" %>
<script>
	$(document).ready(function(){
		$(".pageN").on("click", function(e){
			e.preventDefault();
			pageF = $("#pkc");
			console.log("pagination button clicked....");
			var page = $(this).attr("href");
			console.log("page : " + page);
			pageF.find("input[name='page']").val(page);
			pageF.find("input[name='startRecord']").val((page-1)*10);
			pageF.submit();
		});
	});
</script>