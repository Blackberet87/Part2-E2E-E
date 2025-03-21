#modloaded thaumicwonders randomtweaker
#priority 950

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.randomtweaker.jei.IJeiUtils;

function registerStoneCategory(ID as string, catalysts as IItemStack[]) as void {
  val SLOT_SIZE = 18;
  val ARROW_WIDTH = SLOT_SIZE + 4;
  val p =mods.jei.JEI.createJei(ID, game.localize(`e2ee.jei.${ID}.title`))
    .setBackground(IJeiUtils.createBackground(2 * SLOT_SIZE + ARROW_WIDTH, SLOT_SIZE))
    .setIcon(catalysts[0])
    .setModid('thaumicwonders')
    .addSlot(IJeiUtils.createItemSlot('input', 0, 0, true, false))
    .addElement(IJeiUtils.createArrowElement(SLOT_SIZE, 1, 0))
    .addSlot(IJeiUtils.createItemSlot('output', SLOT_SIZE + ARROW_WIDTH, 0, false, false));

  for cat in catalysts {
    p.addRecipeCatalyst(cat);
  }

  p.register();
}

// -----------------------------------------------------------------------
registerStoneCategory('alchemists_stone', [<thaumicwonders:alchemist_stone>, <thaumicwonders:catalyzation_chamber>]);
function addAlchemists(input as IIngredient, output as IIngredient) as void {
  mods.jei.JEI.createJeiRecipe('alchemists_stone')
    .addInput(input)
    .addOutput(output)
    .build();
}
// -----------------------------------------------------------------------
registerStoneCategory('alienist_stone', [<thaumicwonders:alienist_stone>, <thaumicwonders:catalyzation_chamber>]);
function addAlienists(input as IIngredient, output as IIngredient) as void {
  mods.jei.JEI.createJeiRecipe('alienist_stone')
    .addInput(input)
    .addOutput(output)
    .build();
}
// -----------------------------------------------------------------------
registerStoneCategory('transmuter_stone', [<thaumicwonders:transmuter_stone>, <thaumicwonders:catalyzation_chamber>]);
function addTransmuters(input as IIngredient, output as IIngredient) as void {
  mods.jei.JEI.createJeiRecipe('transmuter_stone')
    .addInput(input)
    .addOutput(output)
    .build();
}

val refiningResults = scripts.mods.thaumicwonders.transmuterStone.refiningResults;
for i in 0 .. refiningResults.length / 2 {
  val aOreID = refiningResults[i * 2];
  val bOreID = refiningResults[i * 2 + 1];

  var a as IIngredient = null;
  var b as IIngredient = null;

  // Plain ore
  if (!isNull(oreDict[aOreID].firstItem) && !isNull(oreDict[bOreID].firstItem)) {
    a = oreDict[aOreID].firstItem;
    b = oreDict[bOreID].firstItem;
  }

  // All other variants
  for orePrefix in scripts.mods.thaumicwonders.transmuterStone.orePrefixes {
    val aOreEntry = oreDict[orePrefix + aOreID];
    val bOreEntry = oreDict[orePrefix + bOreID];
    if (isNull(aOreEntry.firstItem) || isNull(bOreEntry.firstItem)) continue;
    a = isNull(a) ? aOreEntry.firstItem as IIngredient : a | aOreEntry.firstItem;
    b = isNull(b) ? bOreEntry.firstItem as IIngredient : b | bOreEntry.firstItem;
  }

  if (isNull(a) || isNull(b)) continue;
  addTransmuters(a, b);
  addTransmuters(b, a);
}

// -----------------------------------------------------------------------

// Usage example: https://github.com/Project-AT/ThirdRebirth/blob/3332053abc6df98938b5b92630bcef87a14e1091/.minecraft/scripts/CraftTweaker/Mods/JEI/magneticAttractionJei.zs
val p = mods.jei.JEI.createJei('void_beacon', 'Void Beacon')
.setBackground(IJeiUtils.createBackground(9*18, 5*18))
.addRecipeCatalyst(<thaumicwonders:void_beacon>)
.setIcon(<thaumicwonders:void_beacon>)
.setModid('thaumicwonders');

for y in 0 .. 5 {
  for x in 0 .. 9 {
    p.addSlot(IJeiUtils.createItemSlot('output', x*18, y*18, false, false));
  }
}

p.register();

function addVoidBeaconRecipe(outputs as IIngredient[]) as void {
  mods.jei.JEI.createJeiRecipe('void_beacon').setOutputs(outputs).build();
}

// Recipes from: https://github.com/daedalus4096/ThaumicWonders/blob/251829dee76d72368d0ed0af1f2104121b781e63/src/main/java/com/verdantartifice/thaumicwonders/common/init/InitVoidBeacon.java
addVoidBeaconRecipe([
  <ore:oreLapis>,
  <ore:oreDiamond>,
  <ore:oreRedstone>,
  <ore:oreEmerald>,
  <ore:oreQuartz>,
  <ore:oreIron>,
  <ore:oreGold>,
  <ore:glowstone>,
  <ore:oreCopper>,
  <ore:oreTin>,
  <ore:oreSilver>,
  <ore:oreLead>,
  <ore:oreUranium>,
  <ore:oreRuby>,
  <ore:oreGreenSapphire>,
  <ore:oreSapphire>,
  <ore:stone>,
  <ore:stoneGranite>,
  <ore:stoneDiorite>,
  <ore:stoneAndesite>,
  <ore:cobblestone>,
  <ore:dirt>,
  <ore:grass>,
  <ore:endstone>,
  <ore:gravel>,
  <ore:netherrack>,
  <ore:obsidian>,
  <ore:vine>,
  <ore:cropNetherWart>,
  <ore:blockCactus>,
  <ore:sugarCane>,
  <ore:cropWheat>,
  <ore:cropCarrot>,
  <ore:cropPotato>,
  <ore:string>,
  <ore:slimeball>,
  <ore:leather>,
  <ore:feather>,
  <ore:bone>,
  <ore:egg>,
  <ore:gunpowder>,
  <ore:enderpearl>,
  <ore:oreCinnabar>,
  <ore:oreAmber>,
]);

addVoidBeaconRecipe([
  <thaumcraft:crystal_aer>,
  <thaumcraft:crystal_ignis>,
  <thaumcraft:crystal_aqua>,
  <thaumcraft:crystal_terra>,
  <thaumcraft:crystal_ordo>,
  <thaumcraft:crystal_perditio>,
  <thaumcraft:crystal_vitium>,
  <thaumcraft:taint_fibre>,
  <thaumcraft:taint_crust>,
  <thaumcraft:taint_soil>,
  <thaumcraft:taint_geyser>,
  <thaumcraft:taint_rock>,
  <thaumcraft:taint_feature>,
  <thaumcraft:taint_log>,
  <thaumcraft:log_greatwood>,
  <thaumcraft:leaves_greatwood>,
  <thaumcraft:sapling_greatwood>,
  <thaumcraft:log_silverwood>,
  <thaumcraft:leaves_silverwood>,
  <thaumcraft:sapling_silverwood>,
  <thaumcraft:shimmerleaf>,
  <thaumcraft:cinderpearl>,
  <thaumcraft:vishroom>,
]);

addVoidBeaconRecipe([
  <minecraft:coal_ore>,
  <minecraft:dirt:2>,
  <minecraft:sand>,
  <minecraft:sand:1>,
  <minecraft:sandstone>,
  <minecraft:red_sandstone>,
  <minecraft:mycelium>,
  <minecraft:clay>,
  <minecraft:soul_sand>,
  <minecraft:mossy_cobblestone>,
  <minecraft:log>,
  <minecraft:log:1>,
  <minecraft:log:2>,
  <minecraft:log:3>,
  <minecraft:leaves>,
  <minecraft:leaves:1>,
  <minecraft:leaves:2>,
  <minecraft:leaves:3>,
  <minecraft:sapling>,
  <minecraft:sapling:1>,
  <minecraft:sapling:2>,
  <minecraft:sapling:3>,
  <minecraft:sapling:4>,
  <minecraft:double_plant>,
  <minecraft:double_plant:1>,
  <minecraft:double_plant:2>,
  <minecraft:double_plant:3>,
  <minecraft:double_plant:4>,
  <minecraft:waterlily>,
  <minecraft:deadbush>,
  <minecraft:wheat_seeds>,
  <minecraft:melon_seeds>,
  <minecraft:pumpkin_seeds>,
  <minecraft:beetroot_seeds>,
  <minecraft:red_flower>,
  <minecraft:yellow_flower>,
  <minecraft:brown_mushroom>,
  <minecraft:red_mushroom>,
  <minecraft:apple>,
  <minecraft:beetroot>,
  <minecraft:poisonous_potato>,
  <minecraft:pumpkin>,
  <minecraft:melon_block>,
]);

addVoidBeaconRecipe([
  <minecraft:melon>,
  <minecraft:sponge>,
  <minecraft:sponge:1>,
  <minecraft:wool>,
  <minecraft:magma>,
  <minecraft:chorus_flower>,
  <minecraft:chorus_plant>,
  <minecraft:chorus_fruit>,
  <minecraft:ice>,
  <minecraft:packed_ice>,
  <minecraft:snowball>,
  <minecraft:web>,
  <minecraft:flint>,
  <minecraft:rotten_flesh>,
  <minecraft:spider_eye>,
  <minecraft:fish>,
  <minecraft:fish:1>,
  <minecraft:fish:2>,
  <minecraft:chicken>,
  <minecraft:porkchop>,
  <minecraft:beef>,
  <minecraft:mutton>,
  <minecraft:rabbit>,
  <minecraft:rabbit_foot>,
  <minecraft:rabbit_hide>,
  <minecraft:blaze_rod>,
  <minecraft:ghast_tear>,
  <minecraft:skull>,
  <minecraft:skull:1>,
  <minecraft:skull:2>,
  <minecraft:skull:3>,
  <minecraft:dragon_breath>,
  <minecraft:magma_cream>,
  <minecraft:shulker_shell>,
  <minecraft:prismarine_shard>,
  <minecraft:prismarine_crystals>,
  <minecraft:dye>,
  <minecraft:dye:3>,
  <thaumcraft:nugget:10>,
  <thaumcraft:brain>,
  <thaumcraft:curio:1>,
]);
