package net.joystart.customerservice.dao;

import java.util.List;

import net.joystart.customerservice.entity.QuestionCategory;

public interface QuestionCategoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(QuestionCategory record);

    int insertSelective(QuestionCategory record);

    QuestionCategory selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(QuestionCategory record);

    int updateByPrimaryKey(QuestionCategory record);

	List<QuestionCategory> getAllQuestionCategories();
}