/**
 * Adds a new pack service.
 * @param {PrismaClient} prisma - Prisma client.
 * @param {string} name - The name of the pack.
 * @param {string} owner_id - The ID of the pack owner.
 * @return {Object} An object containing the created pack.
 */

import { Pack } from '../../drizzle/methods/Pack';

export const addPackService = async (name, owner_id) => {
  const packClass = new Pack();
  const newPack = {
    name,
    owner_id,
    is_public: false,
    total_weight: 0,
    total_score: 0,
  };

  // Check if a pack with the same name already exists
  const existingPack = await packClass.findUniquePack({
    where: eq(pack.name, name),
  });

  console.log('existingPack', existingPack);
  if (existingPack) {
    // A pack with the same name already exists
    throw new Error('A pack with the same name already exists');
  }

  // Create the new pack
  const createdPack = await packClass.create({
    ...newPack,
    ownerDocuments: owner_id,
  });

  return { createdPack };
};
