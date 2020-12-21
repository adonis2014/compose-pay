/*
 * Copyright © 2020 pleuvoir (pleuvior@foxmail.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package io.github.pleuvoir.gateway.route;

import io.github.pleuvoir.gateway.constants.ResultCodeEnum;
import io.github.pleuvoir.gateway.exception.BusinessException;
import io.github.pleuvoir.gateway.model.po.MerChannelPO;
import io.github.pleuvoir.gateway.model.po.MerSignFeePO;
import io.github.pleuvoir.gateway.service.internal.MerChannelService;
import io.github.pleuvoir.gateway.service.internal.MerSignFeeService;
import javax.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 路由服务
 *
 * @author <a href="mailto:fuwei@daojia-inc.com">pleuvoir</a>
 */
@Slf4j
@Service
public class RouteServiceImpl implements RouteService {

    @Resource
    private MerChannelService merChannelService;
    @Resource
    private MerSignFeeService signFeeService;

    @Override
    public MerChannelPO find(String mid, String payType, String payWay) throws BusinessException {

        log.info("-=- 渠道路由开始，mid={}，payType={}，payWay={}", mid, payType, payWay);

        //获取商户签约的支付产品
        final MerSignFeePO merSignFeePO = signFeeService.getMerSignsByMidAndPayWayAndPayType(mid, payType, payWay);
        if (merSignFeePO == null) {
            logException(mid, payType, payWay, ResultCodeEnum.MER_UN_SIGN_ERROR.getMsg());
            throw new BusinessException(ResultCodeEnum.MER_UN_SIGN_ERROR);
        }

        //获取商户通道关系
        MerChannelPO merChannelPO = merChannelService.maxPriority(mid, payType, payWay);
        if (merChannelPO == null) {
            logException(mid, payType, payWay, ResultCodeEnum.NOT_FOUND_CHANNEL_MID.getMsg());
            throw new BusinessException(ResultCodeEnum.NOT_FOUND_CHANNEL_MID);
        }

        //获取商户通道支付产品


        log.info("-=- 渠道路由结束，mid={}，payType={}，payWay={}", mid, payType, payWay);

        return merChannelPO;
    }


    private void logException(String mid, String payType, String payWay, String message) {
        log.warn("-=- 渠道路由异常<{}>，mid={}，payType={}，payWay={}", message, mid, payType, payWay);
    }

}
