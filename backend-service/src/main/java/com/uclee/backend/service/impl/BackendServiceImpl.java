package com.uclee.backend.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

import com.uclee.fundation.data.mybatis.mapping.*;
import com.uclee.fundation.data.mybatis.model.*;
import com.uclee.fundation.data.web.dto.*;
import org.apache.poi.hssf.record.formula.functions.Na;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;

import com.alibaba.fastjson.JSON;
import com.backend.model.ProductForm;
import com.backend.service.BackendServiceI;
import com.uclee.date.util.DateUtils;
import com.uclee.file.util.FileUtil;
import com.uclee.fundation.config.links.WebConfig;
import com.uclee.fundation.dfs.fastdfs.FDFSFileUpload;
import com.uclee.number.util.NumberUtil;

public class BackendServiceImpl implements BackendServiceI {


	@Autowired
	private CommentMapper commentMapper;
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private ShippingFullCutMapper shippingFullCutMapper;
	@Autowired
	private FullCutMapper fullCutMapper;
	@Autowired
	private BindingRewardsMapper bindingRewardsMapper;
	@Autowired
	private CategoryMapper categoryMapper;
	@Autowired
	private HomeQuickNaviMapper homeQuickNaviMapper;
	@Autowired
	private QuickNaviProductLinkMapper quickNaviProductLinkMapper;
	@Autowired
	private BannerMapper bannerMapper;
	@Autowired
	private MsgRecordMapper msgRecordMapper;
	@Autowired
	private FDFSFileUpload fDFSFileUpload;
	@Autowired
	private ProductGroupLinkMapper productGroupLinkMapper;
	@Autowired
	private BirthVoucherMapper birthVoucherMapper;
	@Autowired
	private OauthLoginMapper oauthLoginMapper;
	@Autowired
	private ProductGroupMapper productGroupMapper;
	@Autowired
	private ConfigMapper configMapper;
	@Autowired
	private FreightMapper freightMapper;
	@Autowired
	private ProductCategoryLinkMapper productCategoryLinkMapper;
	@Autowired
	private ProductImageLinkMapper productImageLinkMapper;
	@Autowired
	private ProductMapper productMapper;
	@Autowired
	private StoreInfoMapper storeInfoMapper;
	@Autowired
	private SpecificationValueMapper specificationValueMapper;
	@Autowired
	private SpecificationValueStoreLinkMapper specificationValueStoreLinkMapper;
	@Autowired
	private NapaStoreMapper napaStoreMapper;
	@Autowired
	private RechargeConfigMapper rechargeConfigMapper;
	@Autowired
	private LotteryDrawConfigMapper lotteryDrawConfigMapper;
	@Autowired
	private HongShiMapper hongShiMapper;
	@Autowired
	private UserProfileMapper userProfileMapper;
	@Autowired
	private VarMapper varMapper;
	@Override
	public boolean updateConfig(ConfigPost configPost) { 
		
		boolean flag = true;
		if(!(configMapper.updateByTag(WebConfig.drawPoint, configPost.getDrawPoint())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.firstDis, configPost.getFirstDis())>0))   flag=false;
		if(!(configMapper.updateByTag(WebConfig.registPoint, configPost.getRegistPoint())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.secondDis, configPost.getSecondDis())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.signInPoint, configPost.getSignInPoint())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.APPID, configPost.getAppId())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.AppSecret, configPost.getAppSecret())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.APPKEY, configPost.getAppKey())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.MERCHANT_CODE, configPost.getMerchantCode())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.NOTIFY_URL, configPost.getNotifyUrl())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.FIRST_PRIZE, configPost.getFirstPrize())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.SECOND_PRIZE, configPost.getSecondPrize())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.THIRD_PRIZE, configPost.getThirdPrize())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.FIRST_COUNT, configPost.getFirstCount())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.SECOND_COUNT, configPost.getSecondCount())>0)) flag=false;
		if(!(configMapper.updateByTag(WebConfig.THIRD_COUNT, configPost.getThirdCount())>0)) flag=false;
		if (configPost.getAlipayNotifyUrl()!=null) {
			configMapper.updateByTag(WebConfig.alipayNotifyUrl, configPost.getAlipayNotifyUrl());
		}else{
			configMapper.updateByTag(WebConfig.alipayNotifyUrl, "");
		}
		if (configPost.getSellerId()!=null) {
			configMapper.updateByTag(WebConfig.sellerId, configPost.getSellerId());
		}else{
			configMapper.updateByTag(WebConfig.sellerId, "");
		}
		if (configPost.getKey()!=null) {
			configMapper.updateByTag(WebConfig.key, configPost.getKey());
		}else{
			configMapper.updateByTag(WebConfig.key, "");
		}
		if (configPost.getPartner()!=null) {
			configMapper.updateByTag(WebConfig.partner, configPost.getPartner());
		}else{
			configMapper.updateByTag(WebConfig.partner, "");
		}
		if (configPost.getAliAppkey()!=null) {
			configMapper.updateByTag(WebConfig.aliAppkey, configPost.getAliAppkey());
		}else{
			configMapper.updateByTag(WebConfig.aliAppkey, "");
		}
		if (configPost.getAliAppSecret()!=null) {
			configMapper.updateByTag(WebConfig.aliAppSecret, configPost.getAliAppSecret());
		}else{
			configMapper.updateByTag(WebConfig.aliAppSecret, "");
		}
		if (configPost.getTemplateCode()!=null) {
			configMapper.updateByTag(WebConfig.templateCode, configPost.getTemplateCode());
		}else{
			configMapper.updateByTag(WebConfig.templateCode, "");
		}
		if (configPost.getSignName()!=null) {
			configMapper.updateByTag(WebConfig.signName, configPost.getSignName());
		}else{
			configMapper.updateByTag(WebConfig.signName, "");
		}
		if (configPost.getBirthTemId()!=null) {
			configMapper.updateByTag(WebConfig.birthTmpId, configPost.getBirthTemId());
		}else{
			configMapper.updateByTag(WebConfig.birthTmpId, "");
		}
		if (configPost.getBuyTemId()!=null) {
			configMapper.updateByTag(WebConfig.buyTmpId, configPost.getBuyTemId());
		}else{
			configMapper.updateByTag(WebConfig.buyTmpId, "");
		}
		if (configPost.getPayTemId()!=null) {
			configMapper.updateByTag(WebConfig.payTmpId, configPost.getPayTemId());
		}else{
			configMapper.updateByTag(WebConfig.payTmpId, "");
		}
		if (configPost.getRechargeTemId()!=null) {
			configMapper.updateByTag(WebConfig.rechargeTmpId, configPost.getRechargeTemId());
		}else{
			configMapper.updateByTag(WebConfig.rechargeTmpId, "");
		}
		if (configPost.getBindText()!=null) {
			configMapper.updateByTag(WebConfig.bindText, configPost.getBindText());
		}else{
			configMapper.updateByTag(WebConfig.bindText, "");
		}
		if (configPost.getSupportDeliver()!=null) {
			configMapper.updateByTag(WebConfig.supportDeliver, configPost.getSupportDeliver());
		}else{
			configMapper.updateByTag(WebConfig.supportDeliver, "");
		}
		if (configPost.getDomain()!=null) {
			configMapper.updateByTag(WebConfig.domain, configPost.getDomain());
		}else{
			configMapper.updateByTag(WebConfig.domain, "");
		}
		if (configPost.getHsMerchantCode()!=null) {
			configMapper.updateByTag(WebConfig.hsMerchatCode, configPost.getHsMerchantCode());
		}else{
			configMapper.updateByTag(WebConfig.hsMerchatCode, "");
		}
		return true;
	}

	@Override
	public List<Freight> selectAllFreight() {

		return freightMapper.selectAllAsc();
	}
	@Override
	public List<FullCut> selectAllFullCut() {

		return fullCutMapper.selectAll();
	}
	@Override
	public List<BindingRewards> selectAllBindingRewards() {

		return bindingRewardsMapper.selectOne();
	}

	@Override
	public boolean updateFreight(FreightPost freightPost) {
		int delAll = freightMapper.deleteAll();
		if(freightPost.getMyKey()==null||freightPost.getMyValue()==null||freightPost.getMyKey().size()==0||freightPost.getMyValue().size()==0){
			return false;
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			if(entry.getValue()==null||freightPost.getMyValue().get(entry.getKey())==null){
				return false;
			}
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			Freight freight = new Freight();
			freight.setCondition(entry.getValue());
			freight.setMoney(new BigDecimal(freightPost.getMyValue().get(entry.getKey())));
			freightMapper.insertSelective(freight);
		}
		return true;
	}
	@Override
	public boolean updateFullCutShipping(FreightPost freightPost) {
		int delAll = shippingFullCutMapper.deleteAll();
		if(freightPost.getMyKey()==null||freightPost.getMyValue()==null||freightPost.getMyKey().size()==0||freightPost.getMyValue().size()==0||freightPost.getMyValue1()==null||freightPost.getMyValue1().size()==0){
			return false;
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			if(entry.getValue()==null||freightPost.getMyValue().get(entry.getKey())==null){
				return false;
			}
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			ShippingFullCut shippingFullCut1 = new ShippingFullCut();
			shippingFullCut1.setsLimit(entry.getValue());
			shippingFullCut1.setuLimit(Double.parseDouble(freightPost.getMyValue().get(entry.getKey())));
			shippingFullCut1.setCondition(new BigDecimal(freightPost.getMyValue1().get(entry.getKey())));
			shippingFullCut1.setStartTime(DateUtils.parse(freightPost.getStartTimeStr(),DateUtils.FORMAT_LONG));
			shippingFullCut1.setEndTime(DateUtils.parse(freightPost.getEndTimeStr(),DateUtils.FORMAT_LONG));
			shippingFullCutMapper.insertSelective(shippingFullCut1);
		}
		return true;
	}
	@Override
	public boolean updateBindingRewards(FreightPost freightPost) {
		int delAll = bindingRewardsMapper.deleteAll();
		if(freightPost.getMyKey()==null||freightPost.getMyValue()==null||freightPost.getMyKey().size()==0||freightPost.getMyValue().size()==0||freightPost.getMyValue1()==null||freightPost.getMyValue1().size()==0){
			return false;
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			if(entry.getValue()==null||freightPost.getMyValue().get(entry.getKey())==null){
				return false;
			}
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			BindingRewards bindingRewards = new BindingRewards();
			bindingRewards.setPoint(entry.getValue().intValue());
			bindingRewards.setVoucherCode(freightPost.getMyValue().get(entry.getKey()));
			bindingRewards.setAmount(Integer.parseInt(freightPost.getMyValue1().get(entry.getKey())));
			bindingRewardsMapper.insertSelective(bindingRewards);
		}
		return true;
	}
	@Override
	public boolean updateFullCut(FreightPost freightPost) {
		int delAll = fullCutMapper.deleteAll();
		if(freightPost.getMyKey()==null||freightPost.getMyValue()==null||freightPost.getMyKey().size()==0||freightPost.getMyValue().size()==0){
			return false;
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			if(entry.getValue()==null||freightPost.getMyValue().get(entry.getKey())==null){
				return false;
			}
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			FullCut fullCut1 = new FullCut();
			fullCut1.setCondition(new BigDecimal(entry.getValue()));
			fullCut1.setCut(new BigDecimal(freightPost.getMyValue().get(entry.getKey())));
			fullCut1.setStartTime(DateUtils.parse(freightPost.getStartTimeStr(),DateUtils.FORMAT_LONG));
			fullCut1.setEndTime(DateUtils.parse(freightPost.getEndTimeStr(),DateUtils.FORMAT_LONG));
			fullCutMapper.insertSelective(fullCut1);
		}
		return true;
	}
	@Override
	public boolean updateBirthVoucher(BirthVoucherPost birthVoucherPost) {
		int delAll = birthVoucherMapper.deleteAll();
		if(birthVoucherPost.getMyKey()==null||birthVoucherPost.getMyValue()==null||birthVoucherPost.getMyKey().size()==0||birthVoucherPost.getMyValue().size()==0){
			return false;
		}
		for(Map.Entry<Integer, String> entry : birthVoucherPost.getMyKey().entrySet()){
			if(entry.getValue()==null||birthVoucherPost.getMyValue().get(entry.getKey())==null){
				return false;
			}
		}
		for(Map.Entry<Integer, String> entry : birthVoucherPost.getMyKey().entrySet()){
			BirthVoucher tmp = new BirthVoucher();
			tmp.setAmount(Integer.parseInt(birthVoucherPost.getMyValue().get(entry.getKey())));
			tmp.setVoucherCode(entry.getValue().toString());
			birthVoucherMapper.insertSelective(tmp);
		}
		return true;
	}

	@Override
	public List<ShippingFullCut> selectAllShippingFullCut() {
		return shippingFullCutMapper.selectAllShippingFullCut();
	}

	@Override
	@CacheEvict(value = "cookaCache", key = "'config'")
	public boolean updateLottery(LotteryConfigPost post) {
		int delAll = lotteryDrawConfigMapper.deleteAll();
		if(post.getValue()==null||post.getKey()==null){
			return false;
		}
		int maxSize = 8;
		for(int i=0;i<=maxSize-1;i++){
			LotteryDrawConfig config = new LotteryDrawConfig();
			config.setCode(NumberUtil.generateSerialNum());
			if(post.getValue().get(i)==1){
				config.setVoucherCode(post.getKey().get(i));
			}else{
				try {
					config.setMoney(new BigDecimal(post.getKey().get(i)));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			config.setCount(post.getCount().get(i));
			config.setRate(post.getRate().get(i));
			config.setTimeEnd(DateUtils.parse(post.getDateEnd()+" "+post.getTimeEnd()+":00", DateUtils.FORMAT_LONG));
			config.setTimeStart(DateUtils.parse(post.getDateStart()+" "+post.getTimeStart()+":00", DateUtils.FORMAT_LONG));
			config.setLimits(post.getLimits());
			lotteryDrawConfigMapper.insertSelective(config);
		}
		return true;
	}
	@Override
	public boolean updateRechargeConfig(FreightPost freightPost) {
		if(freightPost.getMyKey().size()==0||freightPost.getMyValue().size()==0){
			return false;
		}
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			if(entry.getValue()==null||freightPost.getMyValue().get(entry.getKey())==null||freightPost.getMySelect().get(entry.getKey())==null){
				return false;
			}
		}
		int delAll = rechargeConfigMapper.deleteAll();
		for(Map.Entry<Integer, Double> entry : freightPost.getMyKey().entrySet()){
			RechargeConfig config = new RechargeConfig();
			if(freightPost.getMySelect().get(entry.getKey()).equals(1)){
				config.setRewards(new BigDecimal(freightPost.getMyValue().get(entry.getKey())));
			}else{
				config.setVoucherCode(freightPost.getMyValue().get(entry.getKey()));
			}
			config.setMoney(new BigDecimal(entry.getValue()));
			config.setType(freightPost.getMySelect().get(entry.getKey()));
			rechargeConfigMapper.insertSelective(config);
		}
		return true;
	}

	@Override
	public ProductForm getProductForm(Integer productId) {
		ProductForm productForm = new ProductForm();
		Product product = productMapper.selectByPrimaryKey(productId);
		if(product!=null){
			productForm.setShippingFree(product.getShippingFree());
			productForm.setTitle(product.getTitle());
			productForm.setDescription(FileUtil.UrlRequest(product.getDescription()));
		}
		ProductCategoryLinkKey link = productCategoryLinkMapper.selectByProductId(productId);
		if(link!=null){
			productForm.setCategoryId(link.getCategoryId());
		}
		List<ProductImageLink> imageLink = productImageLinkMapper.selectByProductId(productId);
		String images[] = new String[3];
		for(int i=0;i<imageLink.size();i++){
			images[i] = imageLink.get(i).getImageUrl();
		}
		productForm.setImages(images);
		productForm.setProductId(productId);
		List<ValuePost> valuePost = new ArrayList<ValuePost>();
		List<SpecificationValue> values = specificationValueMapper.selectByProductId(productId);
		for(SpecificationValue value:values){
			ValuePost tmp = new ValuePost();
			tmp.setValueId(value.getValueId());
			tmp.setCode(value.getHsGoodsCode());
			tmp.setHsStock(value.getHsStock());
			tmp.setHsPrice(value.getHsGoodsPrice());
			tmp.setName(value.getValue());
			tmp.setPrePrice(value.getPrePrice());
			List<Integer> storeIds = new ArrayList<Integer>();
			List<NapaStore> stores = napaStoreMapper.selectByValueId(value.getValueId());
			for(NapaStore store:stores){
				storeIds.add(store.getStoreId());
			}
			tmp.setStoreIds(storeIds);
			valuePost.add(tmp);
		}
		productForm.setValuePost(valuePost);
		return productForm;
	}

	@Override
	public List<RechargeConfig> selectAllRechargeConfig() {
		List<RechargeConfig> configs = rechargeConfigMapper.selectAll();
		/*for(RechargeConfig config:configs){
			List<String> extra = new ArrayList<String>();
			int i = 1;
			List<HongShiCoupon> coupon = hongShiMapper.getHongShiCouponByGoodsCode(config.getVoucherCode());
			if (coupon!=null&&coupon.size()>0) {
				String tmp = i + ". " + coupon.get(0).getPayQuota().setScale(2, BigDecimal.ROUND_DOWN)+"元现金优惠券"+config.getAmount()+"张";
				i++;
				extra.add(tmp);
			}
			extra.add(config.getMoney() + "元优惠券1张");
			extra.add(config.getMoney().add(new BigDecimal(10)) +"元优惠券1张");
			List<HongShiCoupon> coupon2 = hongShiMapper.getHongShiCouponByGoodsCode(config.getVoucherCodeSecond());
			if (coupon!=null&&coupon.size()>0) {
				String tmp = i + ". " + coupon.get(0).getPayQuota().setScale(2, BigDecimal.ROUND_DOWN)+"元现金优惠券"+config.getAmountSecond()+"张";
				i++;
				extra.add(tmp);
			}
			List<HongShiCoupon> coupon3 = hongShiMapper.getHongShiCouponByGoodsCode(config.getVoucherCodeThird());
			if (coupon!=null&&coupon.size()>0) {
				String tmp = i + ". " + coupon.get(0).getPayQuota().setScale(2, BigDecimal.ROUND_DOWN)+"元现金优惠券"+config.getAmountThird()+"张";
				i++;
				extra.add(tmp);
			}
			config.setExtra(extra);
		}*/
		return configs;
	}

	@Override
	public List<LotteryDrawConfig> selectAllLotteryDrawConfig() {
		return lotteryDrawConfigMapper.selectAll();
	}

	@Override
	public List<ProductDto> selectAllProduct() {
		List<ProductDto> product = productMapper.getAllProduct(null,null,null,null, null);
		for(ProductDto item:product){
			ProductImageLink link = productImageLinkMapper.selectByProductIdLimit(item.getProductId());
			if(link!=null){
				item.setImage(link.getImageUrl());
			}
			Category category = categoryMapper.selectByPId(item.getProductId());
			if(category!=null){
				item.setCategory(category.getCategory());
			}
		}
		return product;
	}

	@Override
	public List<HongShiOrder> getHongShiOrder(Boolean isEnd) {
		List<HongShiOrder> orders = hongShiMapper.getHongShiOrder(null,isEnd);
		for (HongShiOrder order : orders) {
			List<HongShiOrderItem> orderItems = hongShiMapper.getHongShiOrderItems(order.getId());
			for (HongShiOrderItem item : orderItems) {
				HongShiGoods goods = hongShiMapper.getHongShiGoods(item.getCode());
				if (goods != null) {
					ProductImageLink link = productImageLinkMapper.selectByHongShiGoodsCodeLimit(goods.getCode());
					if (link != null) {
						goods.setImage(link.getImageUrl());
					}
				}
				item.setHongShiGoods(goods);
			}
			order.setOrderItems(orderItems);
		}
		return orders;
	}

	@Override
	public List<UserProfile> getUserList() {
		List<UserProfile> userProfile = userProfileMapper.selectAllProfileList();
		for(UserProfile item:userProfile){
			item.setRegistTimeStr(DateUtils.format(item.getRegistTime(), DateUtils.FORMAT_LONG));
		}
		return userProfile;
	}
	@Override
	public List<UserProfile> getUserListForBirth(String start,String end) {
		if(start==null||end==null){
			return new ArrayList<UserProfile>();
		}
		List<UserProfile> userProfile = userProfileMapper.getUserListForBirth(start,end);
		for(UserProfile item : userProfile){
			item.setBirthStr(DateUtils.format(item.getBirth(), DateUtils.FORMAT_SHORT));
		}
		return userProfile;
	}
	@Override
	public List<UserProfile> getUserListForUnBuy(Integer day) {
		List<UserProfile> userProfile = userProfileMapper.getUserListForUnBuy(day);
		for(UserProfile item : userProfile){
			item.setLastBuyStr(DateUtils.format(item.getLastBuy(), DateUtils.FORMAT_SHORT));
		}
		return userProfile;
	}

	@Override
	public ConfigPost getConfig() {
		ConfigPost configPost = new ConfigPost();
		List<Config> configs = configMapper.selectAll();
		for(Config config:configs){
			if(config.getTag().equals(WebConfig.APPID)){
				configPost.setAppId(config.getValue());
			}else if(config.getTag().equals(WebConfig.APPKEY)){
				configPost.setAppKey(config.getValue());
			}else if(config.getTag().equals(WebConfig.AppSecret)){
				configPost.setAppSecret(config.getValue());
			}else if(config.getTag().equals(WebConfig.drawPoint)){
				configPost.setDrawPoint(config.getValue());
			}else if(config.getTag().equals(WebConfig.firstDis)){
				configPost.setFirstDis(config.getValue());
			}else if(config.getTag().equals(WebConfig.MERCHANT_CODE)){
				configPost.setMerchantCode(config.getValue());
			}else if(config.getTag().equals(WebConfig.NOTIFY_URL)){
				configPost.setNotifyUrl(config.getValue());
			}else if(config.getTag().equals(WebConfig.registPoint)){
				configPost.setRegistPoint(config.getValue());
			}else if(config.getTag().equals(WebConfig.secondDis)){
				configPost.setSecondDis(config.getValue());
			}else if(config.getTag().equals(WebConfig.signInPoint)){
				configPost.setSignInPoint(config.getValue());
			}else if(config.getTag().equals(WebConfig.FIRST_PRIZE)){
				configPost.setFirstPrize(config.getValue());
			}else if(config.getTag().equals(WebConfig.SECOND_PRIZE)){
				configPost.setSecondPrize(config.getValue());
			}else if(config.getTag().equals(WebConfig.THIRD_PRIZE)){
				configPost.setThirdPrize(config.getValue());
			}else if(config.getTag().equals(WebConfig.FIRST_COUNT)){
				configPost.setFirstCount(config.getValue());
			}else if(config.getTag().equals(WebConfig.SECOND_COUNT)){
				configPost.setSecondCount(config.getValue());
			}else if(config.getTag().equals(WebConfig.THIRD_COUNT)){
				configPost.setThirdCount(config.getValue());
			}else if(config.getTag().equals(WebConfig.sellerId)){
				configPost.setSellerId(config.getValue());
			}else if(config.getTag().equals(WebConfig.alipayNotifyUrl)){
				configPost.setAlipayNotifyUrl(config.getValue());
			}else if(config.getTag().equals(WebConfig.key)){
				configPost.setKey(config.getValue());
			}else if(config.getTag().equals(WebConfig.partner)){
				configPost.setPartner(config.getValue());
			}else if(config.getTag().equals(WebConfig.aliAppkey)){
				configPost.setAliAppkey(config.getValue());
			}else if(config.getTag().equals(WebConfig.aliAppSecret)){
				configPost.setAliAppSecret(config.getValue());
			}else if(config.getTag().equals(WebConfig.templateCode)){
				configPost.setTemplateCode(config.getValue());
			}else if(config.getTag().equals(WebConfig.signName)){
				configPost.setSignName(config.getValue());
			}else if(config.getTag().equals(WebConfig.birthTmpId)){
				configPost.setBirthTemId(config.getValue());
			}else if(config.getTag().equals(WebConfig.buyTmpId)){
				configPost.setBuyTemId(config.getValue());
			}else if(config.getTag().equals(WebConfig.payTmpId)){
				configPost.setPayTemId(config.getValue());
			}else if(config.getTag().equals(WebConfig.rechargeTmpId)){
				configPost.setRechargeTemId(config.getValue());
			}else if(config.getTag().equals(WebConfig.bindText)){
				configPost.setBindText(config.getValue());
			}else if(config.getTag().equals(WebConfig.supportDeliver)){
				configPost.setSupportDeliver(config.getValue());
			}else if(config.getTag().equals(WebConfig.domain)){
				configPost.setDomain(config.getValue());
			}else if(config.getTag().equals(WebConfig.hsMerchatCode)){
				configPost.setHsMerchantCode(config.getValue());
			}

		}
		return configPost;
	}

	@Override
	public List<Banner> getBannerList() {
		return bannerMapper.selectAll();
	}

	@Override
	public List<ProductGroupLink> getProductGroup(String tag) {
		List<ProductGroupLink> group = null; 
		if(tag!=null&&!tag.equals("")){
			group = productGroupLinkMapper.selectByTag(tag);
		}else{
			group = productGroupLinkMapper.selectAll();
		}
		for(ProductGroupLink item:group){
			ProductDto productDto = productMapper.getProductById(item.getProductId());

			ProductImageLink link = productImageLinkMapper.selectByProductIdLimit(item.getProductId());
			if(link!=null){
				item.setImage(link.getImageUrl());
			}
			ProductGroup productGroup = productGroupMapper.selectByPrimaryKey(item.getGroupId());
			if(productGroup!=null){
				item.setGroupName(productGroup.getGroupName());
			}
		}
		return group;
	}

	@Override
	public boolean editBanner(BannerPost bannerPost) {
		if(bannerPost.getId()!=null){
			Banner banner = bannerMapper.selectByPrimaryKey(bannerPost.getId());
			banner.setImageUrl(bannerPost.getImage());
			banner.setLink(bannerPost.getLink());
			bannerMapper.updateByPrimaryKeySelective(banner);
		}else{
			Banner banner = new Banner();
			banner.setImageUrl(bannerPost.getImage());
			banner.setLink(bannerPost.getLink());
			bannerMapper.insertSelective(banner);
		}
		return true;
	}

	@Override
	public Banner getBanner(Integer id) {
		return bannerMapper.selectByPrimaryKey(id);
	}

	@Override
	public int delBanner(Integer id) {
		return bannerMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int delProductGroup(Integer groupId, Integer productId) {
		return productGroupLinkMapper.del(groupId,productId);
	}

	@Override
	public boolean editProductGroup(ProductGroupPost productGroupPost) {
		ProductGroupLink isExisted = productGroupLinkMapper.selectByGroupIdAndProductId(productGroupPost.getGroupId(), productGroupPost.getProductId());
		if(isExisted!=null){
			return false;
		}
		productGroupLinkMapper.del(productGroupPost.getPreGroupId(),productGroupPost.getPreProductId());
		ProductGroupLink linkTmp = new ProductGroupLink();
		linkTmp.setGroupId(productGroupPost.getGroupId());
		linkTmp.setProductId(productGroupPost.getProductId());
		productGroupLinkMapper.insertSelective(linkTmp);
		return true;
	}

	@Override
	public String selectStoreInfo() {
		StoreInfo storeInfo = storeInfoMapper.selectOne();
		if(storeInfo!=null){
			return FileUtil.UrlRequest(storeInfo.getDescription());
		}
		return "";
	}

	@Override
	public int updateStoreInfo(String description) {
    	File file = FileUtil.convertToFile(description);
        String url = uploadFile(file);
        StoreInfo tmp = storeInfoMapper.selectByPrimaryKey(1);
        if(tmp!=null){
        	tmp.setDescription(url);
        	storeInfoMapper.updateByPrimaryKeySelective(tmp);
        }else{
        	StoreInfo storeInfo = new StoreInfo();
        	storeInfo.setDescription(url);
        	storeInfoMapper.insertSelective(storeInfo);
        }
        file.delete();
		return 0;
	}
	public String uploadFile(File file){
		String url = null;
		url = fDFSFileUpload.getFileId(file);
		return url;
	}

	@Override
	public boolean sendBirthMsg(Integer userId,boolean sendVoucher) {
		OauthLogin login = oauthLoginMapper.getOauthLoginInfoByUserId(userId);
		if(login!=null){
			String nickName="";
			UserProfile profile = userProfileMapper.selectByUserId(userId);
			if(profile!=null){
				nickName = profile.getNickName();
			}
			String[] key = {"keyword1","keyword2","keyword3"};
			String[] value = {nickName,DateUtils.format(new Date(), DateUtils.FORMAT_LONG).toString(),"生日祝福"};
			Config config = configMapper.getByTag("birthTmpId");
			Config config1 = configMapper.getByTag(WebConfig.hsMerchatCode);
			Config config2 = configMapper.getByTag(WebConfig.domain);
			Config config3 = configMapper.getByTag(WebConfig.signName);
			if(config!=null){
				//EMzRY8T0fa90sGTBYZkINvxTGn_nvwKjHZUxtpTmVew
				sendWXMessage(login.getOauthId(), config.getValue(), config2.getValue()+"?merchantCode="+config1.getValue(), config3.getValue()+"商城预祝您生日快乐，赶快过来选取您的专属生日蛋糕吧", key,value, "");
				MsgRecord msgRecord = new MsgRecord();
				msgRecord.setType(1);
				msgRecord.setUserId(userId);
				msgRecordMapper.insertSelective(msgRecord);
			}
			//联动送礼券
			if(sendVoucher) {
				try {
					List<BirthVoucher> birthVouchers = birthVoucherMapper.selectAll();
					for(BirthVoucher birthVoucher:birthVouchers) {
						List<HongShiCoupon> coupon = hongShiMapper.getHongShiCouponByGoodsCode(birthVoucher.getVoucherCode());
						if (coupon != null && coupon.size() > 0) {
							try {
								for(int i=0;i<birthVoucher.getAmount();i++) {
									hongShiMapper.saleVoucher(login.getOauthId(), coupon.get(0).getVouchersCode(), birthVoucher.getVoucherCode());
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					}
				}catch (Exception e){
					e.printStackTrace();
				}
			}
			return true;
		}
		return false;
	}
	@Override
	public boolean sendUnbuyMsg(Integer userId) {
		OauthLogin login = oauthLoginMapper.getOauthLoginInfoByUserId(userId);
		if(login!=null){
			String nickName="";
			UserProfile profile = userProfileMapper.selectByUserId(userId);
			if(profile!=null){
				nickName = profile.getNickName();
			}
			String[] key = {"keyword1","keyword2","keyword3"};
			String[] value = {nickName,DateUtils.format(new Date(), DateUtils.FORMAT_LONG).toString(),"消费提醒"};
			Config config = configMapper.getByTag("buyTmpId");
			Config config1 = configMapper.getByTag(WebConfig.hsMerchatCode);
			Config config2 = configMapper.getByTag(WebConfig.domain);
			Config config3 = configMapper.getByTag(WebConfig.signName);
			if(config!=null){
				//EMzRY8T0fa90sGTBYZkINvxTGn_nvwKjHZUxtpTmVew
				sendWXMessage(login.getOauthId(), config.getValue(), config2.getValue()+"?merchantCode="+config1.getValue(), config3.getValue()+"商城促销大优惠，赶紧来抢购吧", key,value, "");
				MsgRecord msgRecord = new MsgRecord();
				msgRecord.setType(2);
				msgRecord.setUserId(userId);
				msgRecordMapper.insertSelective(msgRecord);
			}
			return true;
		}
		return false;
	}
	public String sendWXMessage(String openId,String templateId,String url, String firstData,String[] key,String[] value,String remarkData) {
		Map<String,Object> sendData = new LinkedHashMap<String,Object>();
		sendData.put("touser", openId);
		sendData.put("template_id", templateId);
		sendData.put("topcolor", "#FF0000");
		sendData.put("url", url);
		Map<String,Object> mainData = new TreeMap<String,Object>();
		
		Map<String,Object> mapFirst = new TreeMap<String,Object>();
		mapFirst.put("value", firstData);
		mainData.put("first", mapFirst);
		
		for(int i=0;i<key.length;i++){
			Map<String,Object> Keyword = new TreeMap<String,Object>();
			Keyword.put("value", value[i]);
			mainData.put(key[i], Keyword);
		}
		
		Map<String,Object> mapRemark = new TreeMap<String,Object>();
		mapRemark.put("value", remarkData);
		mapRemark.put("color", "#173177");
		mainData.put("remark", mapRemark);
		
		sendData.put("data", mainData);
		try {
        Var var = varMapper.selectByPrimaryKey(new Integer(1));
        URL urlPost = new URL("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" + var.getValue());// 创建连接  
        HttpURLConnection connection = (HttpURLConnection) urlPost  
                .openConnection();  
        connection.setDoOutput(true);  
        connection.setDoInput(true);  
        connection.setUseCaches(false);  
        connection.setInstanceFollowRedirects(true);  
        connection.setRequestMethod("POST"); // 设置请求方式  
        connection.setRequestProperty("Accept", "application/json"); // 设置接收数据的格式  
        connection.setRequestProperty("Content-Type", "application/json"); // 设置发送数据的格式  
        connection.connect();  
        OutputStreamWriter out = new OutputStreamWriter(  
                connection.getOutputStream(), "UTF-8"); // utf-8编码  
        out.append(JSON.toJSONString(sendData));  
        out.flush();  
        out.close();
        
        BufferedReader reader = new BufferedReader(new InputStreamReader(
                connection.getInputStream()));
        String lines;
        StringBuffer sb = new StringBuffer("");
        while ((lines = reader.readLine()) != null) {
            lines = new String(lines.getBytes(), "utf-8");
            sb.append(lines);
        }
        System.err.println(sb);
        reader.close();
        // 断开连接
        connection.disconnect();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean delStore(Integer storeId) {
		napaStoreMapper.deleteByPrimaryKey(storeId);
		specificationValueStoreLinkMapper.delByStoreId(storeId);
		return true;
	}

	@Override
	public boolean editQiuckNavi(HomeQuickNavi homeQuickNavi) {
		if(homeQuickNavi.getNaviId()!=null){
			HomeQuickNavi tmp = homeQuickNaviMapper.selectByPrimaryKey(homeQuickNavi.getNaviId());
			tmp.setImageUrl(homeQuickNavi.getImageUrl());
			tmp.setTitle(homeQuickNavi.getTitle());
			homeQuickNaviMapper.updateByPrimaryKeySelective(tmp);
		}else{
			HomeQuickNavi tmp = new HomeQuickNavi();
			tmp.setImageUrl(homeQuickNavi.getImageUrl());
			tmp.setTitle(homeQuickNavi.getTitle());
			homeQuickNaviMapper.insertSelective(tmp);
		}
		return true;
	}

	@Override
	public HomeQuickNavi getQuickNavi(Integer naviId) {
		return homeQuickNaviMapper.selectByPrimaryKey(naviId);
	}

	@Override
	public List<HomeQuickNavi> getQuickNaviList() {
		return homeQuickNaviMapper.selectAll();
	}

	@Override
	public int delQiuckNavi(Integer naviId) {
		return homeQuickNaviMapper.deleteByPrimaryKey(naviId);
	}

	@Override
	public boolean editQuickNaviProduct(QuickNaviProductPost quickNaviProductPost) {
		System.out.println(JSON.toJSONString(quickNaviProductPost));
		for(Integer productId:quickNaviProductPost.getProductIds()){
			if(quickNaviProductLinkMapper.selectByNaviIdAndProductId(quickNaviProductPost.getNaviId(),productId)==null){
				QuickNaviProductLink link = new QuickNaviProductLink();
				link.setProductId(productId);
				link.setNaviId(quickNaviProductPost.getNaviId());
				quickNaviProductLinkMapper.insertSelective(link);
			}
		}
		return true;
	}

	@Override
	public List<ProductDto> selectQuickNaviProduct(Integer naviId) {
		List<ProductDto> product = productMapper.selectQuickNaviProduct(naviId);
		for(ProductDto item:product){
			ProductImageLink link = productImageLinkMapper.selectByProductIdLimit(item.getProductId());
			if(link!=null){
				item.setImage(link.getImageUrl());
			}
		}
		return product;
	}

	@Override
	public int delQuickNaviProduct(Integer naviId, Integer productId) {
		return quickNaviProductLinkMapper.deleteByNIdAndPId(naviId,productId);
	}

	@Override
	public String getHongShiStoreName(String hsCode) {
		List<NapaStore> napaStores = napaStoreMapper.selectByHsCode(hsCode);
		if(napaStores!=null&&napaStores.size()>=1){
			return napaStores.get(0).getStoreName();
		}
		return null;
	}
	@Override
	public NapaStore getHongShiStore(String hsCode) {
		List<NapaStore> napaStores = napaStoreMapper.selectByHsCode(hsCode);
		if(napaStores!=null&&napaStores.size()>=1){
			return napaStores.get(0);
		}
		return null;
	}

	@Override
	public List<ProductDto> selectAllProductByCatId(Integer categoryId) {
		List<ProductDto> product =  productMapper.getAllProductByCatId(categoryId);
		for(ProductDto item:product){
			ProductImageLink link = productImageLinkMapper.selectByProductIdLimit(item.getProductId());
			if(link!=null){
				item.setImage(link.getImageUrl());
			}
			Category category = categoryMapper.selectByPId(item.getProductId());
			if(category!=null){
				item.setCategory(category.getCategory());
			}
		}
		return product;
	}

	@Override
	public List<Category> getCategoryList() {
		return categoryMapper.selectAll();
	}

	@Override
	public Map<String,Object> delCategory(Integer categoryId) {
		Map<String,Object> ret = new TreeMap<String,Object>();
		List<ProductCategoryLinkKey> productCategoryLinkKeys = productCategoryLinkMapper.selectByCId(categoryId);
		if(productCategoryLinkKeys!=null&&productCategoryLinkKeys.size()>0){
			ret.put("result",false);
			ret.put("reason","不可删除已经有下属产品的类别");
			return ret;
		}
		if(categoryMapper.deleteByPrimaryKey(categoryId)>0){
			ret.put("result",true);
		}else{
			ret.put("result",false);
			ret.put("reason","网络繁忙");
		}
		return ret;
	}

	@Override
	public Map<String,Object> editCategory(Category category) {
		Map<String,Object> ret = new TreeMap<String,Object>();
		if(category.getCategoryId()!=null){
			Category tmp = categoryMapper.selectByPrimaryKey(category.getCategoryId());
			Category tmp2 = categoryMapper.selectByName(category.getCategory());
			if(tmp2!=null&&tmp2.getCategoryId()!=category.getCategoryId()){
				ret.put("result",false);
				ret.put("reason","该类别已经存在，不可重复添加");
				return ret;
			}
			if(tmp!=null){
				tmp.setCategory(category.getCategory());
				if(categoryMapper.updateByPrimaryKeySelective(category)>0){
					ret.put("result",true);
				}else{
					ret.put("result",false);
					ret.put("reason","网络繁忙");
				}
				return ret;
			}else{
				ret.put("result",false);
				ret.put("reason","网络繁忙");
				return ret;
			}
		}else{
			if(category.getCategory()!=null){
				category.setParentId(0);
				Category tmp2 = categoryMapper.selectByName(category.getCategory());
				if(tmp2!=null){
					ret.put("result",false);
					ret.put("reason","该类别已经存在，不可重复添加");
					return ret;
				}
				if(categoryMapper.insertSelective(category)>0){
					ret.put("result",true);
				}else{
					ret.put("result",false);
					ret.put("reason","网络繁忙");
				}
				return ret;
			}
		}
		return ret;
	}

	@Override
	public Category getCategoryById(Integer categoryId) {
		return categoryMapper.selectByPrimaryKey(categoryId);
	}

	@Override
	public List<Comment> getCommentList() {
		List<Comment> comments = commentMapper.selectAll();
		for (Comment comment:comments){
			Order order  = orderMapper.getOrderListByOrderSerailNum(comment.getOrderSerialNum());
			comment.setOrder(order);
			UserProfile userProfile = userProfileMapper.selectByUserId(comment.getUserId());
			comment.setUserProfile(userProfile);
			comment.setTimeStr(DateUtils.format(comment.getTime(),DateUtils.FORMAT_LONG));
			comment.setBackTimeStr(DateUtils.format(comment.getBackTime(),DateUtils.FORMAT_LONG));
		}
		return comments;
	}

	@Override
	public Map<String,Object> commentBackHandler(Comment comment) {
		Map<String,Object> ret = new TreeMap<String,Object>();
		if(comment.getId()==null||comment.getBackTitle()==null){
			ret.put("result",false);
			ret.put("reason","参数错误");
		}
		Comment tmp = commentMapper.selectByPrimaryKey(comment.getId());
		if(tmp!=null){
			tmp.setBackTime(new Date());
			tmp.setBackTitle(comment.getBackTitle());
			if(commentMapper.updateByPrimaryKeySelective(tmp)>0){
				ret.put("result",true);
			}else{
				ret.put("result",false);
				ret.put("reason","网络繁忙，请稍后重试");
			}
		}else{
			ret.put("result",false);
			ret.put("reason","参数错误");
		}
		return ret;
	}

	@Override
	public boolean updateRechargeConfigNew(RechargeConfig rechargeConfig) {
		if(rechargeConfig.getStartTimeStr()!=null){
			rechargeConfig.setStartTime(DateUtils.parse(rechargeConfig.getStartTimeStr(),DateUtils.FORMAT_LONG));
		}
		if(rechargeConfig.getEndTimeStr()!=null){
			rechargeConfig.setEndTime(DateUtils.parse(rechargeConfig.getEndTimeStr(),DateUtils.FORMAT_LONG));
		}
		if(rechargeConfig.getId()!=null){
			return rechargeConfigMapper.updateByPrimaryKeySelective(rechargeConfig)>0;
		}else{
			return rechargeConfigMapper.insertSelective(rechargeConfig)>0;
		}
	}

	@Override
	public List<RechargeConfig> getRechargeConfigList() {
		List<RechargeConfig> rechargeConfigs = rechargeConfigMapper.selectAll();
		for(RechargeConfig item:rechargeConfigs){
			item.setEndTimeStr(DateUtils.format(item.getEndTime(),DateUtils.FORMAT_LONG));
			item.setStartTimeStr(DateUtils.format(item.getStartTime(),DateUtils.FORMAT_LONG));
		}
		return rechargeConfigs;
	}

	@Override
	public boolean delRechargeConfig(Integer id) {
		return rechargeConfigMapper.deleteByPrimaryKey(id)>0;
	}

	@Override
	public List<BirthVoucher> selectAllBirthVoucher() {
		return birthVoucherMapper.selectAll();
	}
}
