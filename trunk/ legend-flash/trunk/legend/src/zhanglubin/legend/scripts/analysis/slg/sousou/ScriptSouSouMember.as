package zhanglubin.legend.scripts.analysis.slg.sousou
{
	import zhanglubin.legend.game.sousou.character.LSouSouCharacterS;
	import zhanglubin.legend.game.sousou.character.LSouSouMember;
	import zhanglubin.legend.game.sousou.object.LSouSouObject;
	import zhanglubin.legend.utils.LGlobal;

	public class ScriptSouSouMember
	{
		public function ScriptSouSouMember()
		{
		}
		/**
		 * 脚本解析
		 * 操作
		 * 
		 * SouSouMember.remove(人物编号)
		 * @param 脚本信息
		 */
		public static function analysis(value:String):void{
			trace("ScriptSouSouMember analysis = " + value);
			var start:int = value.indexOf("(");
			var end:int = value.indexOf(")");
			var param:Array = value.substring(start + 1,end).split(",");
			var member:LSouSouMember;
			var listlength:int,i:int;
			switch(value.substr(0,start)){
				case "SouSouMember.clear":
					listlength = LSouSouObject.memberList.length;
					LSouSouObject.memberList.splice(0,listlength);
					LGlobal.script.analysis();
					break;
				case "SouSouMember.remove":
					listlength = LSouSouObject.memberList.length
					for(i=0;i<listlength;i++){
						member = LSouSouObject.memberList[i];
						if(member.index == int(param[0])){
							LSouSouObject.memberList.splice(i,1);
							break;
						}
					}
					LGlobal.script.analysis();
					break;
				case "SouSouMember.add":
					var memberxml:XMLList = LSouSouObject.chara["peo"+param[0]];
					memberxml.Index = param[0];
					memberxml.Lv =  param[1];
					member = new LSouSouMember(new XML(memberxml.toString()));
					if(LSouSouObject.memberList == null)LSouSouObject.memberList = new Array();
					LSouSouObject.memberList.push(member);
					trace("SouSouMember.add LSouSouObject.memberList = ",LSouSouObject.memberList);
					LGlobal.script.analysis();
					break;
				case "SouSouMember.addEquipment":
					var mbr:LSouSouMember;
					trace("mbr = ",mbr);
					if(LSouSouObject.sMap == null){
						for each(mbr in LSouSouObject.memberList){
							if(mbr.index == int(param[0])){
								break;
							}else{
								mbr = null;
							}
						}
						if(mbr == null){LGlobal.script.analysis();return;}
						if(param[1] > 0)mbr.helmet = new XMLList("<Helmet>"+param[1]+"</Helmet>");
						if(param[2] > 0)mbr.equipment = new XMLList("<Equipment lv='"+param[3]+"' exp='0'>"+param[2]+"</Equipment>");
						if(param[4] > 0)mbr.weapon = new XMLList("<Weapon lv='"+param[5]+"' exp='0'>"+param[4]+"</Weapon>");
						if(param[6] > 0)mbr.horse = new XMLList("<Horse>"+param[6]+"</Horse>");
						
					}else{
						var charas:LSouSouCharacterS;
						charas = ScriptSouSouSCharacter.getCharacterS(param[0]);
						if(charas == null){LGlobal.script.analysis();return;}
						mbr = charas.member;
						if(param[1] > 0)mbr.helmet = new XMLList("<Helmet>"+param[1]+"</Helmet>");
						if(param[2] > 0)mbr.equipment = new XMLList("<Equipment lv='"+param[3]+"' exp='0'>"+param[2]+"</Equipment>");
						if(param[4] > 0)mbr.weapon = new XMLList("<Weapon lv='"+param[5]+"' exp='0'>"+param[4]+"</Weapon>");
						if(param[6] > 0)mbr.horse = new XMLList("<Horse>"+param[6]+"</Horse>");
						
					}
					trace("mbr = ",mbr.data);
					LGlobal.script.analysis();
					break;
				case "SouSouMember.setMust":
					listlength = LSouSouObject.memberList.length;
					for(i=0;i<listlength;i++){
						member = LSouSouObject.memberList[i];
						if(member.index == int(param[0])){
							member.must = 1;
							break;
						}
					}
					LGlobal.script.analysis();
					break;
				case "SouSouMember.preWar":
					listlength = LSouSouObject.memberList.length
					trace("SouSouMember.preWar length = ",listlength,int(param[0]));
					for(i=0;i<listlength;i++){
						member = LSouSouObject.memberList[i];
						trace("SouSouMember.preWar member = ",member.data.toXMLString());
						if(member.index == int(param[0])){
							if(LSouSouObject.perWarList == null)LSouSouObject.perWarList = new Array();
							LSouSouObject.perWarList.push(member.index);
							break;
						}
					}
					LGlobal.script.analysis();
					break;
			}
		}
	}
}