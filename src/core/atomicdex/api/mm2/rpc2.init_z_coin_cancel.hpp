/******************************************************************************
 * Copyright © 2013-2022 The Komodo Platform Developers.                      *
 *                                                                            *
 * See the AUTHORS, DEVELOPER-AGREEMENT and LICENSE files at                  *
 * the top-level directory of this distribution for the individual copyright  *
 * holder information and the developer policies on copyright and licensing.  *
 *                                                                            *
 * Unless otherwise agreed in a custom licensing agreement, no part of the    *
 * Komodo Platform software, including this file may be copied, modified,     *
 * propagated or distributed except according to the terms contained in the   *
 * LICENSE file                                                               *
 *                                                                            *
 * Removal or modification of this copyright notice is prohibited.            *
 *                                                                            *
 ******************************************************************************/

#pragma once

// Std Headers
#include <optional>

// Deps Headers
#include <nlohmann/json.hpp>

//! Project Headers
#include "generic.error.hpp"

namespace atomic_dex::mm2
{
    struct init_z_coin_cancel_request
    {
        int         task_id;
    };

    void to_json(nlohmann::json& j, const init_z_coin_cancel_request& request);

    struct init_z_coin_cancel_answer_success
    {
        std::string result;
    };

    void from_json(const nlohmann::json& j, init_z_coin_cancel_answer_success& answer);

    struct init_z_coin_cancel_answer
    {
        std::optional<init_z_coin_cancel_answer_success> result;
        std::optional<generic_answer_error>              error;
        std::string                                      raw_result;      ///< internal
        int                                              rpc_result_code; ///< internal
    };

    void from_json(const nlohmann::json& j, init_z_coin_cancel_answer& answer);
}

namespace atomic_dex
{
    using t_init_z_coin_cancel_request         = mm2::init_z_coin_cancel_request;
    using t_init_z_coin_cancel_answer          = mm2::init_z_coin_cancel_answer;
    using t_init_z_coin_cancel_answer_success  = mm2::init_z_coin_cancel_answer_success;
} // namespace atomic_dex
