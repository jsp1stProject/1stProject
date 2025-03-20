package com.sist.vo;

import lombok.Data;

@Data
public class DetailImgVO {
    private int img_id, content_id;
    private String origin_img, thumb_img;
}
