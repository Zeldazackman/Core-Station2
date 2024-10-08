import { BooleanLike } from 'common/react';

import { useBackend } from '../../../../backend';
import { Box, Button, LabeledList } from '../../../../components';

export const GlobalOptions = (props: { taken_over: BooleanLike }) => {
  const { act } = useBackend();

  const { taken_over } = props;

  return (
    <LabeledList.Item label="Global Options">
      <Box>
        {!taken_over ? (
          <>
            <Button.Confirm
              icon="tornado"
              tooltip="Release all captured souls as ghosts."
              tooltipPosition="bottom"
              confirmColor="green"
              confirmIcon="triangle-exclamation"
              onClick={() => act('soulcatcher_release_all')}
            >
              Release Souls
            </Button.Confirm>
            <Button.Confirm
              icon="eraser"
              tooltip="Delete all captured souls if preferences align or release them."
              tooltipPosition="bottom"
              color="red"
              confirmIcon="triangle-exclamation"
              onClick={() => act('soulcatcher_erase_all')}
            >
              Erase Souls
            </Button.Confirm>
          </>
        ) : (
          <Button
            icon="arrow-up-from-bracket"
            color="green"
            tooltip="Release the body back to the owner."
            tooltipPosition="bottom"
            onClick={() => act('soulcatcher_release_control')}
          >
            Release Control
          </Button>
        )}
      </Box>
    </LabeledList.Item>
  );
};
