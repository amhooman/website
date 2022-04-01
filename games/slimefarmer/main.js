var saveData = {
  cash: 1,
  greenJellies: 0,
  blueJellies: 0,
  refineryLvlCost: 10,
  refineryRate: 1,
  greenSlimeCost: 100,
  greenSlimeCount: 1,
  blueSlimeCost: 1000,
  blueSlimeCount: 0,
  looplength: 1000,
}

//TODO: Add Fn to change saveData.looplength in order to 'speed up' all productions

function sellJellies() {
  saveData.cash += (saveData.greenJellies * saveData.refineryRate) + (saveData.blueJellies * saveData.refineryRate)
  saveData.greenJellies = 0
  saveData.blueJellies = 0
  document.getElementById("GreenJellies").innerHTML = saveData.greenJellies + " Green Jellies"
  document.getElementById("BlueJellies").innerHTML = saveData.blueJellies + " Blue Jellies"
  document.getElementById("totalCash").innerHTML = "$" + saveData.cash
}

function jellyLoop() {
  saveData.blueJellies += saveData.blueSlimeCount * 3
  saveData.greenJellies += saveData.greenSlimeCount
  document.getElementById("GreenJellies").innerHTML = saveData.greenJellies + " Green Jellies"
  document.getElementById("BlueJellies").innerHTML = saveData.blueJellies + " Blue Jellies"
}

function upgradeRefinery() {
  if (saveData.cash >= saveData.refineryLvlCost) {
    saveData.cash -= saveData.refineryLvlCost
    saveData.refineryRate += 1
    saveData.refineryLvlCost = Math.floor(1 + (saveData.refineryLvlCost * 1.5))
    document.getElementById("totalCash").innerHTML = '$' + saveData.cash
    document.getElementById("JellyRefinery").innerHTML = "Upgrade Jelly Refinery (Lvl: " + saveData.refineryRate + ") Cost: " + saveData.refineryLvlCost
  }
}

function buyGreenSlime() {
  if (saveData.cash >= saveData.greenSlimeCost) {
    saveData.cash -= saveData.greenSlimeCost
    saveData.greenSlimeCost = Math.floor(Math.pow(saveData.greenSlimeCost, 1.175) + 1.75)
    saveData.greenSlimeCount += 1
    document.getElementById("totalCash").innerHTML = "$" + saveData.cash
    document.getElementById("BuyGreenSlime").innerHTML = "Buy a Green Slime (No: " + saveData.greenSlimeCount + ") Cost: " + saveData.greenSlimeCost
  }
}

function buyBlueSlime() {
  if (saveData.cash >= saveData.blueSlimeCost) {
    saveData.cash -= saveData.blueSlimeCost
    saveData.blueSlimeCost = Math.floor(Math.pow(saveData.blueSlimeCost, 1.19) + 1.75)
    saveData.blueSlimeCount += 1
    document.getElementById("totalCash").innerHTML = "$" + saveData.cash
    document.getElementById("BuyBlueSlime").innerHTML = "Buy a Blue Slime (No: " + saveData.blueSlimeCount + ") Cost: " + saveData.blueSlimeCost
  }
}

var mainLoop = window.setInterval(function() {
  jellyLoop()
}, saveData.looplength)
