#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-0}
USERNAME=${LOCAL_USERNAME:-user}
CHOWNDIRS=${CHOWNDIRS}
VERBOSE=${VERBOSE}

case ${USER_ID} in
   "0")
        # Run as root
        exec "$@"
        ;;
   *)
        # Run as non-root
        adduser -s /bin/bash -u ${USER_ID} -D ${USERNAME}

        # chown dirs
        if [ "${CHOWNDIRS}" ];
        then
            IFS=',' read -r -a array <<< "${CHOWNDIRS}"
            for element in "${array[@]}"
            do
                if [ "${VERBOSE}" ]; then printf "transfering directory ownership for ${element} to ${USER_ID}:${USER_ID} ...\n"; fi
                chown -R ${USER_ID}:${USER_ID} ${element};
            done
        fi

        exec su-exec ${USERNAME} "$@"
        ;;
esac

