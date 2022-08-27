package com.model2.mvc.view.product;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.upload.UploadService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productServiceImpl;
	
	@Autowired
	@Qualifier("uploadServiceImpl")
	UploadService uploadServiceImpl;

	public ProductController() {
		System.out.println(getClass() + " default Constructor()]");
		System.out.println("pageSize : " + pageSize);
		System.out.println("pageUnit : " + pageUnit);
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping(value = "listProduct/{menu}", method = RequestMethod.GET) 
	public String listProduct( @PathVariable String menu, Model model, HttpSession session, Search search) throws Exception {
		System.out.println("/product/listProduct : GET");
		System.out.println(search);
		System.out.println(menu);
		System.out.println(session.getAttribute("user"));
		
		if(((User)session.getAttribute("user")).getUserId().equals("non-member")) {
			//비회원 상품 검색 Anchor Tag 클릭
			System.out.println("비회원으로 들어왔다");
		}else if(((User)session.getAttribute("user")).getRole().equals("admin")) {
			System.out.println("admin계정으로 들어왔다");
		}else {
			System.out.println("user계정으로 들어왔다");
		}

		// 상품검색 클릭했을때 currentPage는 null이다
		int currentPage = 1;

		// 상품검색 클릭시 null, 검색버튼 클릭시 nullString
		if (search.getCurrentPage() != 0) {
			currentPage = search.getCurrentPage();
		}

		// 판매상품관리 클릭시 searchKeyword, searchCondition 둘 다 null ==> nullString 으로 변환
		String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
		String searchCondition = CommonUtil.null2str(search.getSearchCondition());
		
		// 상품명과 상품가격에서 searchKeyword가 문자일때 nullString으로 변환
		if (!searchCondition.trim().equals("1") && !CommonUtil.parsingCheck(searchKeyword)) {
			searchKeyword = "";
		}
		search = new Search(currentPage, searchCondition, searchKeyword, pageSize, search.getPriceSort());
		
		// 검색정보를 넣어서 현재 페이지의 list를 가져온다
		List<Product> prodList = productServiceImpl.getProductList(search);
		int totalCount = productServiceImpl.getProductTotalCount(search);		
		Page resultPage = new Page(currentPage, totalCount, pageUnit, pageSize);
		
		for (int i = 0; i < prodList.size(); i++) {
			System.out.println(getClass() + " : " + prodList.get(i).toString());
		}
		
		List<String> uploadList = new ArrayList<String>();
		for (int i = 0; i < prodList.size(); i++) {
			uploadList.add(uploadServiceImpl.getUploadFile(prodList.get(i).getFileName()).get(0).getFileName());
		}
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("searchVO", search);
		model.addAttribute("list", prodList);
		model.addAttribute("listSize", prodList.size());
		model.addAttribute("uploadList", uploadList);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping( value = "listProduct", method = RequestMethod.POST )
	public String listProduct( @RequestParam("menu") String menu, Model model, User user, HttpSession session, Search search) throws Exception {
		System.out.println("/product/listProduct : POST");
		
		System.out.println(search);
		System.out.println(user);
		System.out.println(menu);
		System.out.println(session.getAttribute("user"));
		
		
		if(((User)session.getAttribute("user")).getUserId().equals("non-member")) {
			//비회원 상품 검색 Anchor Tag 클릭
			System.out.println("비회원으로 들어왔다");
		}else if(((User)session.getAttribute("user")).getRole().equals("admin")) {
			System.out.println("admin계정으로 들어왔다");
		}else {
			System.out.println("user계정으로 들어왔다");
		}

		// 상품검색 클릭했을때 currentPage는 null이다
		int currentPage = 1;

		// 상품검색 클릭시 null, 검색버튼 클릭시 nullString
		if (search.getCurrentPage() != 0) {
			currentPage = search.getCurrentPage();
		}

		// 판매상품관리 클릭시 searchKeyword, searchCondition 둘 다 null ==> nullString 으로 변환
		String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
		String searchCondition = CommonUtil.null2str(search.getSearchCondition());
		
		// 상품명과 상품가격에서 searchKeyword가 문자일때 nullString으로 변환
		if (!searchCondition.trim().equals("1") && !CommonUtil.parsingCheck(searchKeyword)) {
			searchKeyword = "";
		}
		search = new Search(currentPage, searchCondition, searchKeyword, pageSize, search.getPriceSort());
		
		// 검색정보를 넣어서 현재 페이지의 list를 가져온다
		List<Product> prodList = productServiceImpl.getProductList(search);		
		int totalCount = productServiceImpl.getProductTotalCount(search);		
		Page resultPage = new Page(currentPage, totalCount, pageUnit, pageSize);
		
		for (int i = 0; i < prodList.size(); i++) {
			System.out.println(getClass() + " : " + prodList.get(i).toString());
		}
		
		List<String> uploadList = new ArrayList<String>();
		for (int i = 0; i < prodList.size(); i++) {
			uploadList.add(uploadServiceImpl.getUploadFile(prodList.get(i).getFileName()).get(0).getFileName());
		}
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("searchVO", search);
		model.addAttribute("list", prodList);
		model.addAttribute("listSize", prodList.size());
		model.addAttribute("uploadList", uploadList);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}

	/*
	@RequestMapping( value = "getProduct/{prodNo}/{menu}", method = RequestMethod.GET )
	public String getProduct(@PathVariable int prodNo, @PathVariable String menu, Model model ) throws Exception {
		System.out.println("/getProduct : GET");
		List<Upload> uploadList = uploadServiceImpl.getUploadFile(productServiceImpl.getProduct(prodNo).getFileName());
		
		model.addAttribute("productVO", productServiceImpl.getProduct(prodNo));
		model.addAttribute("uploadList", uploadList);
		model.addAttribute("count", uploadList.get(0).getFileCount());
		return "forward:/product/getProduct.jsp";
	}
	*/
	@RequestMapping( value = "addProductView", method = RequestMethod.GET )
	public String addProductView() throws Exception {
		System.out.println("/addProductView : GET");
		return "redirect:/product/addProductView.jsp";
	}

	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute Product productVO,
							@RequestParam("uploadfile") List<MultipartFile> multiFileList,
							HttpServletRequest request,
							Upload uploadVO,
							ArrayList<Upload> uploadList ) throws Exception {
		System.out.println("/product/addProduct : POST");
		
		//고유번호 생성
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
		String fileNo = sdf1.format( Calendar.getInstance().getTime() ) + "";
		
		for(int i = 0; i < multiFileList.size(); i++) {
			multiFileList.get(i).transferTo(new File("C:\\Users\\903-19\\git\\10Model2-Ajax-Refactor\\10.Model2MVCShop(Ajax)Refactor\\src\\main\\webapp\\images\\uploadFiles\\",
					multiFileList.get(i).getOriginalFilename()));
			uploadVO = new Upload();
			uploadVO.setFileNo(fileNo);
			uploadVO.setFileCount(multiFileList.size());
			uploadVO.setFileName(multiFileList.get(i).getOriginalFilename());
			uploadVO.setFile_path("C:\\Users\\903-19\\git\\10Model2-Ajax-Refactor\\10.Model2MVCShop(Ajax)Refactor\\src\\main\\webapp\\images\\uploadFiles\\");
			uploadList.add(uploadVO);
		}
		
		productVO.setFileName(fileNo);		
		productServiceImpl.addProduct(productVO);
		for (Upload upload : uploadList) {
			uploadServiceImpl.addUpload(upload);
		}
		
		request.setAttribute("productVO", productVO);
		request.setAttribute("uploadList", uploadList);
		request.setAttribute("count", uploadVO.getFileCount());
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value = "updateProductView/{prodNo}/{menu}", method = RequestMethod.GET )
	public String updateProductView(@PathVariable int prodNo, @PathVariable String menu, Model model) throws Exception {
		System.out.println("/product/updateProductView : GET");
		
		Product productVO = productServiceImpl.getProduct(prodNo);
		List<Upload> uploadList = uploadServiceImpl.getUploadFile(productVO.getFileName());
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("uploadList", uploadList);
		model.addAttribute("count", uploadList.size());
		
		if( menu.equals("manage") && productVO.getProTranCode() == null ) {
			return "forward:/product/updateProductView.jsp";
		}else {
			return "forward:/product/getProduct.jsp";
		}
	}
	
	@RequestMapping(value = "updateProduct", method = RequestMethod.POST )
	public String updateProduct(@ModelAttribute("productVO") Product productVO,
								@RequestParam("uploadfile") List<MultipartFile> multiFileList,
								HttpServletRequest request,
								Upload uploadVO,
								ArrayList<Upload> uploadList ) throws Exception {
		System.out.println("/product/updateProduct : POST");
		
		// File file = new File(경로 + 파일이름);
		for(int i = 0; i < multiFileList.size(); i++) {
			multiFileList.get(i).transferTo(new File("C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\",
					multiFileList.get(i).getOriginalFilename()));
			uploadVO = new Upload();
			uploadVO.setFileName(multiFileList.get(i).getOriginalFilename());
			uploadVO.setFileNo(productVO.getFileName());
			uploadVO.setFileCount(multiFileList.size());
			uploadVO.setFile_path("C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\");
			
			List<Upload> list = uploadServiceImpl.getUploadFile(productVO.getFileName());
			if(multiFileList.size() >= list.size()) {
				uploadVO.setBefore_fileName(list.get(i).getFileName());
			}else {
				uploadVO.setBefore_fileName("");
			}			
			System.out.println("하나의 upload : " + uploadVO);
			
			uploadList.add(uploadVO);	
		}		
		
		productVO = productServiceImpl.updateProduct(productVO);
		for (Upload upload : uploadList) {
			uploadServiceImpl.updateUpload(upload);
		}
		List<Upload> list = uploadServiceImpl.getUploadFile(uploadList.get(0).getFileNo());
		
		request.setAttribute("productVO", productVO);
		request.setAttribute("uploadList", list);
		request.setAttribute("count", uploadVO.getFileCount());
		
		return "forward:/product/getProduct.jsp";
	}

}


