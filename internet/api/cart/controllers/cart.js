'use strict';

/**
 * Read the documentation (https://strapi.io/documentation/v3.x/concepts/controllers.html#core-controllers)
 * to customize this controller
 */

module.exports = {
  update: async (ctx, next) => {
    const { products } = ctx.request.body;
    return strapi.services.cart.edit(ctx.params, {
      products: JSON.parse(products)
    });
  },

};
