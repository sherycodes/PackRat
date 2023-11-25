import type { Node as TNode } from '@prisma/client/edge';

type ExtendedNode = {
  toJSON: () => Partial<TNode>;
  save: () => Promise<void>;
};

const Node = <T extends TNode>(prismaNode: T): T & ExtendedNode => {
  if (!prismaNode) return;
  return Object.assign(prismaNode, {
    toJSON(prisma: any): Partial<TNode> {
      const {
        id,
        // destructure methods
        toJSON,
        save,
        ...nodeObject
      } = this;
      return nodeObject;
    },
    async save(prisma: any): Promise<void> {
      const {
        // destructure functions
        toJSON,
        save,
        ...nodeObject
      } = this;
      await prisma.node.upsert({
        where: {
          id: nodeObject.id,
        },
        create: nodeObject,
        update: nodeObject,
      });
    },
  });
};

export { Node };
