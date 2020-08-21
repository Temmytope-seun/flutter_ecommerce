'use strict';

const axios = require('axios');
/**
 * Read the documentation (https://strapi.io/documentation/v3.x/concepts/models.html#lifecycle-hooks)
 * to customize this model
 */

//module.exports = {
//  lifecycles: {
//    beforeCreate: async (model) => {
//      const cart = await axios.post('http://10.0.2.2:1337/carts');
//      model.set('cart_id', cart.data.id);
//      console.log('flower', cart);s
//    },
//  },
//
//};

module.exports = {
  /**
   * Triggered before user creation.
   */
     beforeCreate: async model => {
       const cart = await axios.post("http://10.0.2.2:1337/carts");
       model.set("cart_id", cart.data.id);
     },
};

