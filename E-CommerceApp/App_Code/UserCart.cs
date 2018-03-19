using System.Text.RegularExpressions;
using System.Data;
using System.Collections.Generic;
using System;

namespace E_CommerceApp
{
    public class UserCart
    {
        #region Object Properties
        /// <summary>
        /// The list of items in the cart
        /// </summary>
        public string lastInsertedItem { get; set; }
        /// <summary>
        /// The list of the quantities of the items in the cart
        /// </summary>
        public string lastInsertedQuant { get; set; }
        /// <summary>
        /// The list of the prices of the items in the cart
        /// </summary>
        public string lastInsertedPrice { get; set; }
        /// <summary>
        /// The total price of the items in the cart
        /// </summary>
        public decimal totalCartPrice { get; set; }
        /// <summary>
        /// The total quantity of the items in the cart
        /// </summary>
        public int totalItemQuantity { get; set; }
        /// <summary>
        /// The cart's cart ID
        /// </summary>
        public int cartID { get; set; }
        /// <summary>
        /// The owner of the cart
        /// </summary>
        public string cartOwner { get; set; } 
        #endregion

        #region Singleton Implementation
        private static UserCart instance;
        public static UserCart Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new UserCart();
                }

                return instance;
            }
        }
        #endregion

        /// <summary>
        /// Adds the specified item to the cart
        /// </summary>
        /// <param name="itemSKU">The SKU of the item to be added to the cart</param>
        /// <param name="price">The original price of the item to be added to the cart</param>
        /// <param name="quant">The quantity of the item to be added to the cart</param>
        /// <returns></returns>
        public bool AddItem(string itemSKU, decimal price, int quant)
        {
            int index = -1;

            //if the cart is from a returning user, use the stuff in there instead.
            //make sure that the details associated to the cart are properly extracted.
            if (((lastInsertedItem != string.Empty) && (lastInsertedItem != null)))
            {
                if (Regex.IsMatch(lastInsertedItem, string.Format(@"\b{0}\b", itemSKU)))
                {
                    string[] items = lastInsertedItem.Split(',');
                    string[] prices = lastInsertedPrice.Split(',');
                    string[] quantities = lastInsertedQuant.Split(',');
                    for (int i = 0; i < items.Length; i++)
                    {
                        if (items[i] == itemSKU)
                        {
                            index = i;
                            break;
                        }
                    }

                    if (index != -1)
                    {
                        int qT = (Convert.ToInt32(quantities[index].Trim()) + (quant));
                        quantities[index] = qT.ToString();
                        prices[index] = (price * qT).ToString();
                        lastInsertedPrice = string.Join(",", prices);
                        lastInsertedQuant = string.Join(",", quantities);
                        totalCartPrice = ComputeTotalPrice();
                        totalItemQuantity = ComputeTotalItems();
                    }
                }
                else
                {
                    lastInsertedItem += string.Format("{0},", itemSKU);
                    decimal priceB = Convert.ToInt32(quant) * price;
                    lastInsertedPrice += string.Format("{0},", priceB);
                    lastInsertedQuant += string.Format("{0},", quant);
                    totalCartPrice = ComputeTotalPrice();
                    totalItemQuantity = ComputeTotalItems();
                }

                return true;
            }
            else
            {
                lastInsertedItem += string.Format("{0},", itemSKU);
                decimal priceB = Convert.ToInt32(quant) * price;
                lastInsertedPrice += string.Format("{0},", priceB);
                lastInsertedQuant += string.Format("{0},", quant);
                totalItemQuantity += quant;
                totalCartPrice += priceB;
            }

            //insert
            return false;
        }

        /// <summary>
        /// Removes the specified item from the cart
        /// </summary>
        /// <param name="itemSKU">The SKU of the item to be removed from the cart</param>
        /// <param name="price">The original price of the item to be removed</param>
        /// <param name="quant">The quantity of the item to be removed</param>
        public void RemoveItem(string itemSKU, decimal price, int quant)
        {
            int index = -1;

            string[] holdData = DBOps.GetCartItems(cartID);
            lastInsertedItem = holdData[0];
            lastInsertedPrice = holdData[1];
            lastInsertedQuant = holdData[2];
            totalCartPrice = Convert.ToDecimal(holdData[3]);
            totalItemQuantity = Convert.ToInt32(holdData[4]);

            if (((lastInsertedItem != string.Empty) && (lastInsertedItem != null)))
            {
                string[] items = lastInsertedItem.Split(',');
                List<string> newItems = new List<string>();
                List<string> newQuants = new List<string>();
                List<string> newPrices = new List<string>();

                if (Regex.IsMatch(lastInsertedItem, string.Format(@"\b{0}\b", itemSKU)))
                {
                    for (int i = 0; i < items.Length; i++)
                    {
                        if (items[i] == itemSKU)
                        {
                            index = i;
                            break;
                        }
                    }

                    if (index != -1)
                    {
                        string[] prices = lastInsertedPrice.Split(',');
                        string[] quantities = lastInsertedQuant.Split(',');
                        int orriginalQuant = Convert.ToInt32(quantities[index].Trim());
                        int qT = (Convert.ToInt32(quantities[index].Trim()) - (quant));
                        quantities[index] = qT.ToString();
                        prices[index] = ((price / orriginalQuant) * qT).ToString();

                        if (qT <= 0)
                        {
                            newItems = new List<string>(items);
                            newItems.RemoveAt(index);
                            lastInsertedItem = string.Join(",", newItems);

                            newQuants = new List<string>(quantities);
                            newQuants.RemoveAt(index);
                            lastInsertedQuant = string.Join(",", newQuants);

                            newPrices = new List<string>(prices);
                            newPrices.RemoveAt(index);
                            lastInsertedPrice = string.Join(",", newPrices);

                            totalCartPrice = ComputeTotalPrice();
                            totalItemQuantity = ComputeTotalItems();
                        }
                        else
                        {
                            lastInsertedPrice = string.Join(",", prices);
                            lastInsertedQuant = string.Join(",", quantities);
                            totalCartPrice = ComputeTotalPrice();
                            totalItemQuantity = ComputeTotalItems();
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Updates the details of the specified item in the cart
        /// </summary>
        /// <param name="itemSKU">The SKU of the item to be updated</param>
        /// <param name="price">The price of the item to be updated</param>
        /// <param name="quant">The quantity of the item to be updated</param>
        public void UpdateItem(string itemSKU, decimal price, int quant)
        {
            int index = -1;

            string[] holdData = DBOps.GetCartItems(cartID);
            lastInsertedItem = holdData[0];
            lastInsertedPrice = holdData[1];
            lastInsertedQuant = holdData[2];
            totalCartPrice = Convert.ToDecimal(holdData[3]);
            totalItemQuantity = Convert.ToInt32(holdData[4]);

            if (((lastInsertedItem != string.Empty) && (lastInsertedItem != null)))
            {
                string[] items = lastInsertedItem.Split(',');
                List<string> newItems = new List<string>();
                List<string> newQuants = new List<string>();
                List<string> newPrices = new List<string>();

                if (Regex.IsMatch(lastInsertedItem, string.Format(@"\b{0}\b", itemSKU)))
                {
                    for (int i = 0; i < items.Length; i++)
                    {
                        if (items[i] == itemSKU)
                        {
                            index = i;
                            break;
                        }
                    }

                    if (index != -1)
                    {
                        string[] prices = lastInsertedPrice.Split(',');
                        string[] quantities = lastInsertedQuant.Split(',');
                        int originalQuant = Convert.ToInt32(quantities[index].Trim());
                        int qT = (Convert.ToInt32(quant));
                        quantities[index] = qT.ToString();
                        prices[index] = (price * qT).ToString();

                        lastInsertedPrice = string.Join(",", prices);
                        lastInsertedQuant = string.Join(",", quantities);
                        totalCartPrice = ComputeTotalPrice();
                        totalItemQuantity = ComputeTotalItems();
                    }
                }
            }
        }

        /// <summary>
        /// Computes the total number of items in the cart
        /// </summary>
        /// <returns>The total number of items in the user's cart</returns>
        private int ComputeTotalItems()
        {
            string[] itemList = lastInsertedQuant.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            int total = 0;
            for (int i = 0; i < itemList.Length; i++)
            {
                total += Convert.ToInt32(itemList[i]);
            }

            return total;
        }

        /// <summary>
        /// Computes the total price of the items in the cart
        /// </summary>
        /// <returns>The total price of all the items in the user's cart</returns>
        private decimal ComputeTotalPrice()
        {
            string[] priceList = lastInsertedPrice.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            decimal total = 0;
            for (int i = 0; i < priceList.Length; i++)
            {
                total += Convert.ToDecimal(priceList[i]);
            }

            return total;
        }

        /// <summary>
        /// Updates a specified user's cart with data from another cart
        /// </summary>
        /// <param name="cartID">The ID of the cart that's being used</param>
        /// <param name="user">The E-mail address of the user who's cart to sync with</param>
        public void SyncCart(int cartID, string user)
        {
            string[] oldCartData = DBOps.GetUserCart(DBOps.GetLatestEntry(DBOps.GetUserID(user)));
            string[] currentCartData = null;

            string[] r_currCartDataItems = null;
            string[] r_currCartDataPrices = null;
            string[] r_currCartDataQuants = null;
            int r_currQuant = -1;
            decimal r_currPrice = -1;

            lastInsertedItem = oldCartData[0];
            lastInsertedPrice = oldCartData[1];
            lastInsertedQuant = oldCartData[2];
            totalItemQuantity = Convert.ToInt32(oldCartData[3]);
            totalCartPrice = Convert.ToDecimal(oldCartData[4]);

            try
            {
                currentCartData = DBOps.GetUserCart(cartID);
                r_currCartDataItems = currentCartData[0].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                r_currCartDataPrices = currentCartData[1].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                r_currCartDataQuants = currentCartData[2].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                r_currQuant = Convert.ToInt32(currentCartData[3]);
                r_currPrice = Convert.ToDecimal(currentCartData[4]);

                for (int i = 0; i < r_currCartDataItems.Length; i++)
                {
                    AddItem(r_currCartDataItems[i], Convert.ToDecimal(r_currCartDataPrices[i]), Convert.ToInt32(r_currCartDataQuants[i]));
                }
            }
            catch { }
        }

        /// <summary>
        /// Resets the variables used by the cart
        /// </summary>
        public void Reset()
        {
            lastInsertedItem = null;
            lastInsertedPrice = null;
            lastInsertedQuant = null;
            totalCartPrice = 0;
            totalItemQuantity = 0;
        }

        /// <summary>
        /// Validates if the specified item can be added to the cart
        /// </summary>
        /// <param name="itemSKU">The SKU of the item to be added to the cart</param>
        /// <param name="quant">The desired quantity of the item to be added to the cart</param>
        /// <param name="cartID">The ID of the current cart</param>
        /// <returns>True if the item can be added to the cart</returns>
        public bool ItemCanBeAdded(string itemSKU, int quant, int cartID)
        {
            string[] s_lastInsertedItem = lastInsertedItem.Split(new string[] { "," },StringSplitOptions.RemoveEmptyEntries);
            string[] s_lastInsertedQuantity = lastInsertedQuant.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            string[] t_originalCartDetails = DBOps.GetUserCart(cartID);

            for (int i = 0; i < s_lastInsertedItem.Length; i++)
            {
                if(s_lastInsertedItem[i].Trim() == itemSKU.Trim())
                {
                    int t_quant = Convert.ToInt32(s_lastInsertedQuantity[i]);

                    /// The variables in the cart object get updated before
                    /// this method is called. That is why we check if the
                    /// current quantity will equate to an amount that is
                    /// greater than 99 or any defined limit.
                    if(t_quant > 99 || (DBOps.GetProductQuantity(itemSKU) == 0))
                    {
                        lastInsertedPrice = t_originalCartDetails[1];
                        lastInsertedQuant = t_originalCartDetails[2];
                        totalItemQuantity = ComputeTotalItems();
                        totalCartPrice = ComputeTotalPrice();
                        return false;
                    }
                }
            }

            return true;
        }

        /// <summary>
        /// Creates a new user cart
        /// </summary>
        public UserCart()
        {
            cartID = -1;
            cartOwner = string.Empty;
            lastInsertedItem = "";
            lastInsertedPrice = "";
            lastInsertedQuant = "";
            totalCartPrice = 0;
            totalItemQuantity = 0;
        }
    }
}