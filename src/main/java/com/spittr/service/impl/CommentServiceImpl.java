package com.spittr.service.impl;

import com.spittr.exception.InvalidParameterException;
import com.spittr.mapper.CommentMapper;
import com.spittr.pojo.Comment;
import com.spittr.service.CommentService;
import com.spittr.service.SpittleService;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    private final org.slf4j.Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private SpittleService spittleService;

    public Comment comment(String username, long spittleId, String text) {
        Comment comment = new Comment();
        comment.setText(text);
        comment.setSpittleId(spittleId);
        comment.setUsername(username);
        return comment(comment);
    }

    @Override
    public Comment comment(Comment comment) {
        boolean exists = spittleService.queryIfExistById(comment.getSpittleId());
        if (!exists) {
            throw new InvalidParameterException("spittle[" + comment.getSpittleId() + "] doesn't exists.");
        }
        commentMapper.insertOne(comment);
        return getLatestComment(comment.getSpittleId(), comment.getUsername());
    }

    public boolean queryIfCommentExistsById(long commentId) {
        return commentMapper.selectCommentCountByCommentId(commentId) > 0;
    }

    public boolean deleteComment(String username, long commentId) {
        if (!queryIfCommentExistsById(commentId)) {
            throw new InvalidParameterException("comment[" + commentId + "] doesn't exists");
        }
        commentMapper.deleteComment(username, commentId);
        return true;
    }

    public List<Comment> getComments(long spittleId) {
        boolean exists = spittleService.queryIfExistById(spittleId);
        if (!exists) {
            throw new InvalidParameterException("spittle[" + spittleId + "]doesn't exists.");
        }
        return commentMapper.selectBySpittleId(spittleId);
    }

    public int getCount(long spittleId) {
        int count = commentMapper.selectCount(spittleId);
        return count;
    }

    public Comment getLatestComment(long spittleId, String username) {
        return commentMapper.selectLatestOne(spittleId, username);
    }
}
