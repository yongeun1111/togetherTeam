package com.example.portfolio_23.domain.mapper;

import com.example.portfolio_23.domain.entity.User;

import java.util.List;


public interface UserMapper {
    public User save(User user);
    public List<User> all();

}
