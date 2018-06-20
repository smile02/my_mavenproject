package com.inc.service;

import java.util.List;

import com.inc.vo.Board;

public interface BoardService {

	List<Board> list(String option, String text, int page);

	int getTotalCount(String option, String text, int page);

	void insert(Board board);

	void delete(int id);

	Board selectOne(int id);

	void update(Board board);

	void updateStep(Board board);

	void comment(Board board);

	
}
