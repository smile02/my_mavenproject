package com.inc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.inc.service.BoardService;
import com.inc.service.BoardServiceImpl;
import com.inc.service.FileService;
import com.inc.util.Paging;
import com.inc.vo.Board;

@Controller
public class BoardController {
	
	private Paging paging;
	
	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	private BoardService boardService;
	
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	
	private FileService fileService;
	
	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	
	@RequestMapping(value="/board/list", method=RequestMethod.GET)
	public String list(@RequestParam(required=false) String option,
					   @RequestParam(required=false) String text,
					   @RequestParam(defaultValue="1") int page,
					   Model model) {
		
		String searchParam = "";
		if(option != null && !option.equals("all")) { //전체검색 외에 다른 옵션을 선택 했다는 뜻
			searchParam = "&option="+option+"&text="+text;
		}
		
		model.addAttribute("boardList",
				boardService.list(option,text,page));
		
		model.addAttribute("paging", paging.getPaging("/board/list",
													page,
													boardService.getTotalCount(option,text,page),
													BoardServiceImpl.numberOfList,
													BoardServiceImpl.numberOfPage,
													searchParam));
		
		return "/board/list.jsp";
	}
	
	@RequestMapping(value="/board/view", method = RequestMethod.GET)
	public String view(@RequestParam int id,Model model) {		
		model.addAttribute("board",boardService.selectOne(id));
		
		return "/board/view.jsp";
	}
	
	@RequestMapping(value="/board/insert", method=RequestMethod.GET)
	public String insert() {
		return "/board/insert.jsp";
	}
	
	@RequestMapping(value="/board/insert", method=RequestMethod.POST)
	public String insert(@ModelAttribute Board board,HttpServletRequest request) {
		
		board.setIp(request.getRemoteAddr());
		boardService.insert(board);
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam int id) {
		boardService.delete(id);
		return "y";
	}
	
	@RequestMapping(value="/board/update", method=RequestMethod.GET)
	public String update(@RequestParam int id,Model model) {
		Board board = boardService.selectOne(id);
		
		model.addAttribute("board",board);		
		return "/board/update.jsp";
	}
	
	@RequestMapping(value="/board/update", method=RequestMethod.POST)
	public String update(@ModelAttribute Board board) {
		boardService.update(board);
		
		return "redirect:/board/view?id="+board.getId();
	}
	
	@RequestMapping(value="/board/comment", method=RequestMethod.GET)
	public String comment(@RequestParam int id,Model model) {
		model.addAttribute("board",boardService.selectOne(id));
		
		return "/board/comment.jsp";		
	}
	
	@RequestMapping(value="/board/comment", method=RequestMethod.POST)
	public String comment(@ModelAttribute Board board, HttpServletRequest request) {
		
		Board oriBoard = boardService.selectOne(board.getId());
				
		board.setRef(oriBoard.getRef());
		board.setDepth(oriBoard.getDepth()+1);
		board.setStep(oriBoard.getStep()+1);
		board.setIp(request.getRemoteAddr());

		// step변경 : step값이 크거나 같은 애들은 step+1
		boardService.updateStep(board);
		// 답글추가
		boardService.comment(board);

		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/board/fileupload", method=RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest request,Model model,@RequestParam MultipartFile upload,
			HttpServletResponse response) {
		String json="";
		System.out.println("upload : "+upload.getOriginalFilename());
		try {
			//파일 저장
			String path = request.getServletContext().getRealPath("/WEB-INF/resources/image/upload");
			String filename = fileService.saveFile(path, upload);
			response.setContentType("application/json");			
			json = String.format(
							"{\"url\":\"%s/WEB-INF/resources/image/upload/%s\"}", request.getContextPath(),filename);
			System.out.println("json : "+json);

		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "서버오류입니다.");
			model.addAttribute("url","/product/list");
			return "/error.jsp";
		}
		System.out.println("json 2: "+json);
		
		return json;
	}
}
