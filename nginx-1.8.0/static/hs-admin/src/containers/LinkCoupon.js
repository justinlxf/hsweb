import React from 'react'
import DocumentTitle from 'react-document-title'

// fto 可以将表单装换成 json
import fto from 'form_to_object'
import './global-config.css'
import {values} from 'lodash'

import values1 from 'lodash'

// 创建 less 文件，但是引用 css 文件
import './voucher-delivery.css'

// req 用于发送 AJAX 请求
import req from 'superagent'

// ErrorMsg 显示表单错误
import ErrorMsg from '../components/ErrorMsg'

import ValueGroup from '../components/ValueGroupTmp'

class LinkCoupon extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      err: null,
      count: 1,
      initValue: null, //刚开始要设置成 null，只会从外部拿一次数据
      initRow: 2,
      html: '',
      config:{}
    }
  }

  componentDidMount() {
    req.get('/uclee-backend-web/LinkCoupons').end((err, res) => {
      if (err) {
        return err
      }
      var data = JSON.parse(res.text)
      this.setState({
        initRow: data.size,
        initValue: data.data
      })
      console.log(this.state.initValue);
    })
    
    req.get('/uclee-backend-web/config').end((err, res) => {
      if (err) {
        return err
      }
      var data = JSON.parse(res.text)
      this.setState({
        config: data.config,
      })
    })
  }
  
  render() {
    return (
      <DocumentTitle title="优惠券领取设置">
        <div className="freight">
          {/* 类名加上页面前缀防止冲突 */}
          <form onSubmit={this._submit} className="form-horizontal">
            <div className="form-group ">
              <label className="control-label col-md-3">优惠券领取设置：</label>
              <div className="col-md-9">

                {this.state.initValue
                  ? <ValueGroup
                      condition={'领取'}
                      keyText={'优惠券对应商品号'}
                      valueText={'单次领取数量'}
                      value1Text={'优惠券名称'}
                      keyName={'myKey'}
                      valueName={'myValue'}
                      value1Name={'myValue1'}
                      maxRow={5}
                      initRow={this.state.initRow}
                      initValue={this.state.initValue}
                    />
                  : null}
              </div>
            </div>
            <div className="form-group ">
          		<label className="control-label col-md-3" style={{marginTop:'10px'}}>礼券领取规则内容：</label>
              <div className="col-md-9" style={{marginTop:'10px'}}>
                <textarea rows="3" cols="20" value={this.state.config.linkCouponText} name="linkCouponText" className="form-control" onChange={this._change}>
                </textarea>
              </div>
          	</div>
          	<div className="form-group ">
              <label className="control-label col-md-3">分享链接：</label>
              <div className="col-md-9">
          			{this.state.config.domain + "/link-coupon?merchantCode=" + localStorage.getItem('merchantCode')}
          		</div>
          	</div>
            <ErrorMsg msg={this.state.err} />
            <div className="form-group">
              <div className="col-md-9 col-md-offset-3">
                <button type="submit" className="btn btn-primary">提交</button>
              </div>
            </div>
          </form>
        </div>
      </DocumentTitle>
    )
  }
  _change = (e) => {
    var c = Object.assign({}, this.state.config)
    c[e.target.name] = e.target.value
    this.setState({
      config: c
    })
  }
  _submit = e => {
    e.preventDefault()
    var data = fto(e.target)
    console.log(data)
    if(values(data.myKey).length!==values(data.myValue).length||values(data.myValue1).length!==values(data.myValue).length){
      this.setState({
        err: "信息填写不完整"
      })
      return;
    }
    
		for(var i=0; i<values(data.myValue).length; i++){
			if(values(data.myValue)[i]>1){
      this.setState({
        err: "数量不能大于1"
      })
      return;
    }
		}
    
    
    if(!data.linkCouponText) {
      return this.setState({
        err: '请填写推送信息内容!'
      })
    }

      data.myKey = values1(data.myKey)
      data.myValue = values1(data.myValue)
      this.setState({
        err: null
      })

      // return
      //推送内容信息
   	  req
      .post('/uclee-backend-web/activityConfigHandler')
      
      .send(data)
      .end((err, res) => {
        if (err) {
          return err
        }
      })
	
      req.post('/uclee-backend-web/linkCouponHandler').send(data).end((err, res) => {
        if (err) {
          return err
        }

        if (res.text) {
          window.location = '/linkCoupon'
        }
      })
  }
}

export default LinkCoupon