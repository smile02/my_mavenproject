package com.inc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inc.service.ReplyService;
import com.inc.vo.Reply;

@Controller
public class ReplyController {

	private ReplyService replyService;

	public void setReplyService(ReplyService replyService) {
		this.replyService = replyService;
	}
	
	@RequestMapping(value="/reply/insert", method=RequestMethod.POST)
	public String insert(@ModelAttribute Reply reply) {
		
		replyService.insert(reply);
		
		return "redirect:/board/view?id="+reply.getB_id();
	}
	
}
